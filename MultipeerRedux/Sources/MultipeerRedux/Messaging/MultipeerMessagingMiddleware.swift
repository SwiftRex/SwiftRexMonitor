import Combine
import Foundation
import MultipeerCombine
import MultipeerConnectivity
import SwiftRex

public final class MultipeerMessagingMiddleware: Middleware {
    public typealias InputActionType = MultipeerSessionMessagingAction
    public typealias OutputActionType = MultipeerSessionMessagingAction
    public typealias StateType = Void

    private var output: AnyActionHandler<OutputActionType>?
    private let session: MultipeerSession
    private var messageSubscription: AnyCancellable?

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
        case .stoppedMonitoring:
            break
        case let .sendData(data):
            sendData(data)
        case let .sendDataToPeer(data, peer):
            sendData(data, to: peer.peerInstance)
        case .gotData,
             .sendDataResult:
            break
        }
    }

    private func startMonitoring() {
        messageSubscription = session.messages.sink(
            receiveCompletion: { [weak self] _ in
                self?.output?.dispatch(.stoppedMonitoring)
            },
            receiveValue: { [weak self] event in
                switch event {
                case let .data(data, peer, _):
                    self?.output?.dispatch(.gotData(data, from: Peer(peerInstance: peer)))
                case .didFinishReceivingResource, .didStartReceivingResource, .stream:
                    break
                }
            }
        )
    }

    private func sendData(_ data: Data, to peer: MCPeerID? = nil) {
        output?.dispatch(
            .sendDataResult(
                data,
                to: peer.map(Peer.init),
                result: peer.map {
                    session.send(data, to: $0)
                } ?? session.sendToAll(data)
            )
        )
    }
}
