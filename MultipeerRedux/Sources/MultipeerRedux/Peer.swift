import Foundation
import MultipeerConnectivity

public struct Peer: Codable, Equatable {
    public let peerInstance: MCPeerID

    public init(peerInstance: MCPeerID) {
        self.peerInstance = peerInstance
    }

    enum CodingKeys: String, CodingKey {
        case displayName
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(peerInstance.displayName, forKey: .displayName)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        peerInstance = .init(displayName: try container.decode(String.self, forKey: .displayName))
    }
}

public func == (lhs: Peer, rhs: Peer) -> Bool {
    lhs.peerInstance.displayName == rhs.peerInstance.displayName
}
