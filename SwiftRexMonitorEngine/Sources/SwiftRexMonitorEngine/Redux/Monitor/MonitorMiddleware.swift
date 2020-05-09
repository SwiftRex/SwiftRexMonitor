import Combine
import Foundation
import MonitoredAppMiddleware
import MultipeerCombine
import MultipeerMiddleware
import SwiftRex

final class MonitorMiddleware: Middleware {
    typealias InputActionType = MonitorAction
    typealias OutputActionType = MonitorAction
    typealias StateType = [MonitoredPeer]

    private let session: () -> MultipeerSession
    private let decoder: () -> JSONDecoder
    private var output: AnyActionHandler<OutputActionType>?
    private var getState: GetState<StateType>?
    private var cancellables = Set<AnyCancellable>()

    init(multipeerSession: @escaping () -> MultipeerSession, decoder: @escaping () -> JSONDecoder) {
        self.session = multipeerSession
        self.decoder = decoder
    }

    func receiveContext(getState: @escaping GetState<StateType>, output: AnyActionHandler<OutputActionType>) {
        self.getState = getState
        self.output = output
    }

    func handle(action: InputActionType, from dispatcher: ActionSource, afterReducer: inout AfterReducer) {
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
                    state: message.state.map {
                        do {
                            return try decoder().decode(GenericObject.self, from: $0)
                        } catch {
                            return .string("Decoding error: \(error.localizedDescription)")
                        }
                    },
                    stateData: message.state,
                    actionSource: message.actionSource,
                    peer: peer
                )
            )
        case let .introduction(introduction):
            let initialStateData = introduction.initialState
            let initialState = (try? decoder().decode(GenericObject.self, from: initialStateData)) ?? .null
            output?.dispatch(.gotGreetings(introduction, initialState: initialState, initialStateData: initialStateData, peer: peer))
        }
    }
}
