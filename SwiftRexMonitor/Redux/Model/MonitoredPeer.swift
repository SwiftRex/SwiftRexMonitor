import Foundation
import MonitoredAppMiddleware
import MultipeerMiddleware

public struct MonitoredPeer: Codable, Equatable {
    public var peer: Peer
    public var isConnected: Bool
    public var metadata: PeerMetadata?
    public var history: [ActionMessage]
}
