import Foundation
import MultipeerConnectivity

public struct MultipeerAdvertiserAcceptance {
    private let predicate: (MCPeerID, Data?) -> Bool
    init(predicate: @escaping (MCPeerID, Data?) -> Bool) {
        self.predicate = predicate
    }

    public func shouldAccept(invitedBy peerID: MCPeerID, context: Data?) -> Bool {
        predicate(peerID, context)
    }
}

extension MultipeerAdvertiserAcceptance {
    public static var always: MultipeerAdvertiserAcceptance = .init(predicate: { _, _ in true })
    public static var never: MultipeerAdvertiserAcceptance = .init(predicate: { _, _ in false })
    public static var whenPeer: (@escaping (MCPeerID) -> (Bool)) -> MultipeerAdvertiserAcceptance = { whenPeer in
        .init(predicate: { peer, _ in whenPeer(peer) })
    }
    public static var whenPeerAndContext: (@escaping (MCPeerID, Data?) -> (Bool)) -> MultipeerAdvertiserAcceptance = { whenPeerAndContext in
        .init(predicate: { peer, context in whenPeerAndContext(peer, context) })
    }
}
