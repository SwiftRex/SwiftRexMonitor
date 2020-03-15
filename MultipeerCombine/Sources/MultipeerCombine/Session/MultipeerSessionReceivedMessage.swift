import Foundation
import MultipeerConnectivity

public enum MultipeerSessionReceivedMessage {
    case data(Data, from: MCPeerID, session: MCSession)
    case stream(InputStream, streamName: String, from: MCPeerID, session: MCSession)
    case didStartReceivingResource(resourceName: String, from: MCPeerID, progress: Progress, session: MCSession)
    case didFinishReceivingResource(resourceName: String, from: MCPeerID, localURL: URL?, error: Error?, session: MCSession)
}
