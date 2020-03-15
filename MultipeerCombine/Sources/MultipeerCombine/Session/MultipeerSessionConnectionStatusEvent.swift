import Foundation
import MultipeerConnectivity

public enum MultipeerSessionConnectionStatusEvent {
    case peerIsConnecting(MCPeerID, session: MCSession)
    case peerConnected(MCPeerID, session: MCSession)
    case peerDisconnected(MCPeerID, session: MCSession)
}
