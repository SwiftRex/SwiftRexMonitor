import Combine
import Foundation
import MultipeerConnectivity

final class MultipeerAdvertiserSubscription<S: Subscriber>: NSObject, MCNearbyServiceAdvertiserDelegate, Subscription
where S.Input == MultipeerAdvertiserEvent, S.Failure == Error {
    private var requested: Subscribers.Demand = .none
    private var delivered: Subscribers.Demand = .none
    private var subscriber: S?
    private let advertiser: MCNearbyServiceAdvertiser

    init(subscriber: S, peer: MCPeerID, serviceType: String, discoveryInfo: [String: String]? = nil) {
        self.subscriber = subscriber
        self.advertiser = MCNearbyServiceAdvertiser(peer: peer, discoveryInfo: discoveryInfo, serviceType: serviceType)
        super.init()
        self.advertiser.delegate = self
    }

    func request(_ demand: Subscribers.Demand) {
        increaseDemand(demand)
    }

    func cancel() {
        advertiser.stopAdvertisingPeer()
        requested = .none
        delivered = .none
        subscriber = nil
    }

    func advertiser(
        _ advertiser: MCNearbyServiceAdvertiser,
        didReceiveInvitationFromPeer peerID: MCPeerID,
        withContext context: Data?,
        invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        increaseDemand(
            subscriber?.receive(.didReceiveInvitationFromPeer(peerID, context: context, handler: invitationHandler))
        )
    }

    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        subscriber?.receive(completion: .failure(error))
    }

    private func increaseDemand(_ increment: Subscribers.Demand?) {
        DispatchQueue.main.async {
            let first = self.requested == .none
            self.requested += increment ?? .none
            if first && self.requested != .none {
                // Start advertising
                self.advertiser.startAdvertisingPeer()
            }

            // TODO: Implement backpressure
        }
    }
}
