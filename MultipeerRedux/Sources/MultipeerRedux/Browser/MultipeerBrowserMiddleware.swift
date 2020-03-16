import Combine
import Foundation
import MultipeerCombine
import MultipeerConnectivity
import SwiftRex

public final class MultipeerBrowserMiddleware: Middleware {
    public typealias InputActionType = MultipeerBrowserAction
    public typealias OutputActionType = MultipeerBrowserAction
    public typealias StateType = MultipeerBrowserState

    private let browser: () -> MultipeerBrowserPublisher
    private var output: AnyActionHandler<OutputActionType>?
    private let session: MultipeerSession
    private var browserSubscription: AnyCancellable?
    private let autoInvite: MultipeerBrowserAutoInvite
    private let timeout: TimeInterval
    private var invitations = Set<AnyCancellable>()

    public init(
        browser: @escaping () -> MultipeerBrowserPublisher,
        session: @escaping () -> MultipeerSession,
        autoInvite: MultipeerBrowserAutoInvite = .always,
        timeout: TimeInterval = 10
    ) {
        self.browser = browser
        self.session = session()
        self.autoInvite = autoInvite
        self.timeout = timeout
    }

    public func receiveContext(getState: @escaping GetState<StateType>, output: AnyActionHandler<OutputActionType>) {
        self.output = output
    }

    public func handle(action: InputActionType, from dispatcher: ActionSource, afterReducer: inout AfterReducer) {
        switch action {
        case .startBrowsing:
            startBrowsing()
        case .stopBrowsing:
            stopBrowsing()
        case let .manuallyInvite(peer, browser):
            invite(peer: peer.peerInstance, browser: browser)
        case .foundPeer,
             .lostPeer,
             .startedBrowsing,
             .stoppedBrowsing,
             .stoppedBrowsingDueToError,
             .didSendInvitation,
             .remoteAcceptedInvitation,
             .remoteDeclinedInvitation:
            break
        }
    }
    private func invite(peer: MCPeerID, browser: MCNearbyServiceBrowser) {
        session.invite(peer: peer, browser: browser, context: nil, timeout: timeout).sink(
            receiveCompletion: { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.output?.dispatch(.remoteDeclinedInvitation(Peer(peerInstance: peer), error: error))
                case .finished:
                    break
                }
            },
            receiveValue: { [weak self] peer in
                self?.output?.dispatch(.remoteAcceptedInvitation(Peer(peerInstance: peer)))
            }
        ).store(in: &invitations)

        output?.dispatch(.didSendInvitation(Peer(peerInstance: peer)))
    }

    private func startBrowsing() {
        browserSubscription = browser().sink(
            receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.output?.dispatch(.stoppedBrowsing)
                case let .failure(error):
                    self?.output?.dispatch(.stoppedBrowsingDueToError(error))
                }
            },
            receiveValue: { [weak self] event in
                guard let self = self else { return }
                switch event {
                case let .foundPeer(peer, info, browser):
                    self.output?.dispatch(.foundPeer(Peer(peerInstance: peer), info: info, browser: browser))
                    if self.autoInvite.shouldInviteAutomatically(peerID: peer, info: info) {
                        self.invite(peer: peer, browser: browser)
                    }
                case let .lostPeer(peer):
                    self.output?.dispatch(.lostPeer(Peer(peerInstance: peer)))
                }
            }
        )
        output?.dispatch(.startedBrowsing)
    }

    private func stopBrowsing() {
        browserSubscription = nil
    }
}
