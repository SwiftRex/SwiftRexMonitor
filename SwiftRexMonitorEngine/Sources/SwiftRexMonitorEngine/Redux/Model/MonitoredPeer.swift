import Foundation
import MonitoredAppMiddleware
import MultipeerMiddleware

public struct MonitoredPeer: Codable, Equatable {
    public var id: Int {
        peer.peerInstance.hash
    }
    public var peer: Peer
    public var isConnected: Bool
    public var metadata: PeerMetadata?
    public var history: [ActionHistoryEntry]
}
