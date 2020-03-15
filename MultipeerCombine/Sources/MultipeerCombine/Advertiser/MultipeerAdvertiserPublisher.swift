import Combine
import Foundation
import MultipeerConnectivity

public struct MultipeerAdvertiserPublisher: Publisher {
    public typealias Output = MultipeerAdvertiserEvent
    public typealias Failure = Error
    private let peer: MCPeerID
    private let serviceType: String
    private let discoveryInfo: [String: String]?

    public init(myselfAsPeer: MCPeerID, serviceType: String, discoveryInfo: [String: String]? = nil) {
        self.peer = myselfAsPeer
        self.serviceType = serviceType
        self.discoveryInfo = discoveryInfo
    }

    public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        let subscription = MultipeerAdvertiserSubscription(
            subscriber: subscriber,
            peer: peer,
            serviceType: serviceType,
            discoveryInfo: discoveryInfo
        )
        subscriber.receive(subscription: subscription)
    }
}
