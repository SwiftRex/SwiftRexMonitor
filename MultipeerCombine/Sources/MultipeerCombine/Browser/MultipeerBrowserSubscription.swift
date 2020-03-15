import Combine
import Foundation
import MultipeerConnectivity

final class MultipeerBrowserSubscription<S: Subscriber>: NSObject, MCNearbyServiceBrowserDelegate, Subscription
where S.Input == MultipeerBrowserEvent, S.Failure == Error {
    private var requested: Subscribers.Demand = .none
    private var delivered: Subscribers.Demand = .none
    private var subscriber: S?
    private let browser: MCNearbyServiceBrowser

    init(subscriber: S, peer: MCPeerID, serviceType: String) {
        self.subscriber = subscriber
        self.browser = MCNearbyServiceBrowser(peer: peer, serviceType: serviceType)
        super.init()
        self.browser.delegate = self
    }

    func request(_ demand: Subscribers.Demand) {
        increaseDemand(demand)
    }

    func cancel() {
        browser.stopBrowsingForPeers()
        requested = .none
        delivered = .none
        subscriber = nil
    }

    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        increaseDemand(
            subscriber?.receive(.foundPeer(peerID: peerID, info: info, browser: browser))
        )
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        increaseDemand(
            subscriber?.receive(.lostPeer(peerID: peerID))
        )
    }

    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        subscriber?.receive(completion: .failure(error))
    }

    private func increaseDemand(_ increment: Subscribers.Demand?) {
        DispatchQueue.main.async {
            let first = self.requested == .none
            self.requested += increment ?? .none
            if first && self.requested != .none {
                // Start monitoring
                self.browser.startBrowsingForPeers()
            }

            // TODO: Implement backpressure
        }
    }
}
