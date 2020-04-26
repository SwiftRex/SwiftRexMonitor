import Foundation
import MonitoredAppMiddleware
import MultipeerMiddleware
import SwiftRex

public struct MonitoredPeer: Codable, Equatable {
    public var peer: Peer
    public var isConnected: Bool
    public var metadata: PeerMetadata?
    public var history: [ActionHistoryEntry]
}

public struct ActionHistoryEntry: Codable, Equatable {
    public let remoteDate: Date
    public let action: String
    public let state: String?
    public let actionSource: ActionSource
}
