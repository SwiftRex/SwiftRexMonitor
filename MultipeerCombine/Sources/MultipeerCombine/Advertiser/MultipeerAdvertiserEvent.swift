import Foundation
import MultipeerConnectivity

public enum MultipeerAdvertiserEvent {
    case didReceiveInvitationFromPeer(MCPeerID, context: Data?, handler: (Bool, MCSession?) -> Void)
}
