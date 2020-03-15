import Foundation
import MultipeerConnectivity

public enum MultipeerBrowserEvent {
    case foundPeer(peerID: MCPeerID, info: [String: String]?, browser: MCNearbyServiceBrowser)
    case lostPeer(peerID: MCPeerID)
}
