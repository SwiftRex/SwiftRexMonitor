import Combine
import Foundation
import MonitoredAppMiddleware
import MultipeerCombine
import MultipeerMiddleware
import SwiftRex

public final class MultipeerBridgeMonitorMiddleware: Middleware {
    public typealias InputActionType = AppAction
    public typealias OutputActionType = AppAction
    public typealias StateType = Void

    private var output: AnyActionHandler<OutputActionType>?
    private var getState: GetState<StateType>?
    private var cancellables = Set<AnyCancellable>()

    public init() {
    }

    public func receiveContext(getState: @escaping GetState<StateType>, output: AnyActionHandler<OutputActionType>) {
        self.getState = getState
        self.output = output
    }

    public func handle(action: InputActionType, from dispatcher: ActionSource, afterReducer: inout AfterReducer) {
        switch action {
        case .start:
            start()
        case .multipeer(.connectivity(.peerConnected)), .multipeer(.connectivity(.peerDisconnected)):
            output?.dispatch(.monitor(.peerListNeedsRefresh))
        case let .multipeer(.messaging(.gotData(data, peer))):
            output?.dispatch(.monitor(.evaluateData(data, from: peer)))
        default:
            break
        }
    }

    private func start() {
        output?.dispatch(.monitor(.start))
        output?.dispatch(.multipeer(.connectivity(.startMonitoring)))
        output?.dispatch(.multipeer(.messaging(.startMonitoring)))
        output?.dispatch(.multipeer(.browser(.startBrowsing)))
    }
}

public final class MonitorMiddleware: Middleware {
    public typealias InputActionType = MonitorAction
    public typealias OutputActionType = MonitorAction
    public typealias StateType = [MonitoredPeer]

    private let session: () -> MultipeerSession
    private let decoder: () -> JSONDecoder
    private var output: AnyActionHandler<OutputActionType>?
    private var getState: GetState<StateType>?
    private var cancellables = Set<AnyCancellable>()

    public init(
        multipeerSession: @escaping () -> MultipeerSession,
        decoder: @escaping () -> JSONDecoder
    ) {
        self.session = multipeerSession
        self.decoder = decoder
    }

    public func receiveContext(getState: @escaping GetState<StateType>, output: AnyActionHandler<OutputActionType>) {
        self.getState = getState
        self.output = output
    }

    public func handle(action: InputActionType, from dispatcher: ActionSource, afterReducer: inout AfterReducer) {
        switch action {
        case .start:
            start()
        case .peerListNeedsRefresh:
            peerListNeedsRefresh()
        case let .evaluateData(data, peer):
            evaluate(data: data, from: peer)
        case .peerListHasChanged,
             .gotAction,
             .gotGreetings:
            break
        }
    }

    private func start() {
        let connectedPeers = session().session.connectedPeers
        guard !connectedPeers.isEmpty else { return }
        output?.dispatch(.peerListHasChanged(connectedPeers.map(Peer.init)))
    }

    private func peerListNeedsRefresh() {
        let connectedPeers = session().session.connectedPeers
        output?.dispatch(.peerListHasChanged(connectedPeers.map(Peer.init)))
    }

    private func evaluate(data: Data, from peer: Peer) {
        guard let statePeers = getState?(),
            statePeers.contains(where: { peerInState in peerInState.peer.peerInstance.displayName == peer.peerInstance.displayName }) else {
            return
        }

        guard let decodedMessage = Result(catching: { try decoder().decode(MessageType.self, from: data) }).success else { return }
        switch decodedMessage {
        case let .action(message):
            output?.dispatch(
                .gotAction(
                    action: message.action,
                    remoteDate: message.remoteDate,
                    state: message.state.flatMap { String(data: $0, encoding: .utf8) },
                    actionSource: message.actionSource,
                    peer: peer
                )
            )
        case let .introduction(introduction):
            output?.dispatch(.gotGreetings(introduction, peer: peer))
        }
    }
}
