import Foundation
import MonitoredAppMiddleware
import MultipeerMiddleware

// sourcery: EnumCodable
// sourcery: Prism
public enum MonitorAction {
    case start
    case peerListNeedsRefresh
    case peerListHasChanged([Peer])
    case evaluateData(Data, from: Peer)
    case gotAction(ActionMessage, peer: Peer)
    case gotGreetings(PeerMetadata, peer: Peer)
}
