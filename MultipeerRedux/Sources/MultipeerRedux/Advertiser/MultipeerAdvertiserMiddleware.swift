import Combine
import Foundation
import MultipeerCombine
import MultipeerConnectivity
import SwiftRex

public final class MultipeerAdvertiserMiddleware: Middleware {
    public typealias InputActionType = MultipeerAdvertiserAction
    public typealias OutputActionType = MultipeerAdvertiserAction
    public typealias StateType = MultipeerAdvertiserState

    private let advertiser: () -> MultipeerAdvertiserPublisher
    private var output: AnyActionHandler<OutputActionType>?
    private let session: MultipeerSession
    private let acceptanceCriteria: MultipeerAdvertiserAcceptance
    private var advertisement: AnyCancellable?

    public init(
        advertiser: @escaping () -> MultipeerAdvertiserPublisher,
        session: @escaping () -> MultipeerSession,
        acceptanceCriteria: MultipeerAdvertiserAcceptance = .always
    ) {
        self.advertiser = advertiser
        self.session = session()
        self.acceptanceCriteria = acceptanceCriteria
    }

    public func receiveContext(getState: @escaping GetState<StateType>, output: AnyActionHandler<OutputActionType>) {
        self.output = output
    }

    public func handle(action: InputActionType, from dispatcher: ActionSource, afterReducer: inout AfterReducer) {
        switch action {
        case .startAdvertising:
            startAdvertising()
        case .stopAdvertising:
            stopAdvertising()
        case .startedAdvertising,
             .stoppedAdvertising,
             .stoppedAdvertisingDueToError,
             .invited,
             .acceptedInvitation,
             .declinedInvitation:
            break
        }
    }

    private func startAdvertising() {
        advertisement = advertiser().sink(
            receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.output?.dispatch(.stoppedAdvertising)
                case let .failure(error):
                    self?.output?.dispatch(.stoppedAdvertisingDueToError(error))
                }
            },
            receiveValue: { [weak self] event in
                guard let self = self else { return }
                switch event {
                case let .didReceiveInvitationFromPeer(peer, context, handler):
                    self.output?.dispatch(.invited(by: Peer(peerInstance: peer), context: context))
                    let accepted = self.acceptanceCriteria.shouldAccept(invitedBy: peer, context: context)
                    handler(accepted, self.session.session)
                    self.output?.dispatch(
                        accepted
                            ? .acceptedInvitation(from: Peer(peerInstance: peer), context: context)
                            : .declinedInvitation(from: Peer(peerInstance: peer), context: context)
                    )
                }
            }
        )
        output?.dispatch(.startedAdvertising)
    }

    private func stopAdvertising() {
        advertisement = nil
    }
}
