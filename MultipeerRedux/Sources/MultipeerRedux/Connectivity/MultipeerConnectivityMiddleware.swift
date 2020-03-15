import Combine
import Foundation
import MultipeerCombine
import SwiftRex

public final class MultipeerConnectivityMiddleware: Middleware {
    public typealias InputActionType = MultipeerSessionConnectivityAction
    public typealias OutputActionType = MultipeerSessionConnectivityAction
    public typealias StateType = Void

    private var output: AnyActionHandler<OutputActionType>?
    private let session: MultipeerSession
    private var connectivitySubscription: AnyCancellable?

    public init(session: @escaping () -> MultipeerSession) {
        self.session = session()
    }

    public func receiveContext(getState: @escaping GetState<StateType>, output: AnyActionHandler<OutputActionType>) {
        self.output = output
    }

    public func handle(action: InputActionType, from dispatcher: ActionSource, afterReducer: inout AfterReducer) {
        switch action {
        case .startMonitoring:
            startMonitoring()
        default:
            break
        }
    }

    private func startMonitoring() {
        connectivitySubscription = session.connections.sink(
            receiveCompletion: { [weak self] _ in
                self?.output?.dispatch(.stoppedMonitoring)
            },
            receiveValue: { [weak self] event in
                switch event {
                case let .peerConnected(peer, _):
                    self?.output?.dispatch(.peerConnected(Peer(peerInstance: peer)))
                case let .peerDisconnected(peer, _):
                    self?.output?.dispatch(.peerDisconnected(Peer(peerInstance: peer)))
                case let .peerIsConnecting(peer, _):
                    self?.output?.dispatch(.peerIsConnecting(Peer(peerInstance: peer)))
                }
            }
        )
    }
}
