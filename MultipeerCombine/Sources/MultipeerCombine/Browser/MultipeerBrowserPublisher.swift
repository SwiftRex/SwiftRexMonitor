import Combine
import Foundation
import MultipeerConnectivity

public struct MultipeerBrowserPublisher: Publisher {
    public typealias Output = MultipeerBrowserEvent
    public typealias Failure = Error
    private let peerID: MCPeerID
    private let serviceType: String

    public init(myselfAsPeer: MCPeerID, serviceType: String) {
        self.peerID = myselfAsPeer
        self.serviceType = serviceType
    }

    public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = MultipeerBrowserSubscription(subscriber: subscriber, peer: peerID, serviceType: serviceType)
        subscriber.receive(subscription: subscription)
    }
}
