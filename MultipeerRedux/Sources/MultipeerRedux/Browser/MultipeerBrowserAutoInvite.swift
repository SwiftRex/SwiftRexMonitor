import Foundation
import MultipeerConnectivity

public struct MultipeerBrowserAutoInvite {
    private let predicate: (MCPeerID, [String: String]?) -> Bool
    init(predicate: @escaping (MCPeerID, [String: String]?) -> Bool) {
        self.predicate = predicate
    }

    public func shouldInviteAutomatically(peerID: MCPeerID, info: [String: String]?) -> Bool {
        predicate(peerID, info)
    }
}

extension MultipeerBrowserAutoInvite {
    public static var always: MultipeerBrowserAutoInvite = .init(predicate: { _, _ in true })
    public static var never: MultipeerBrowserAutoInvite = .init(predicate: { _, _ in false })
    public static var whenPeer: (@escaping (MCPeerID) -> (Bool)) -> MultipeerBrowserAutoInvite = { whenPeer in
        .init(predicate: { peer, _ in whenPeer(peer) })
    }
    public static var whenPeerAndInfo: (@escaping (MCPeerID, [String: String]?) -> (Bool)) -> MultipeerBrowserAutoInvite = { whenPeerAndInfo in
        .init(predicate: { peer, info in whenPeerAndInfo(peer, info) })
    }
}
