import Foundation
import MultipeerConnectivity

// sourcery: EnumCodable
// sourcery: Prism
public enum MultipeerSessionConnectivityAction {
    case startMonitoring
    case stoppedMonitoring
    case peerConnected(Peer)
    case peerDisconnected(Peer)
    case peerIsConnecting(Peer)
}
