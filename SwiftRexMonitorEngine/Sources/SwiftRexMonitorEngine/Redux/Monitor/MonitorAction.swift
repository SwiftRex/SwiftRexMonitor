import Foundation
import MonitoredAppMiddleware
import MultipeerMiddleware
import SwiftRex

// sourcery: EnumCodable
// sourcery: Prism
public enum MonitorAction {
    case start
    case peerListNeedsRefresh
    case peerListHasChanged([Peer])
    case evaluateData(Data, from: Peer)
    case gotAction(action: String, remoteDate: Date, state: GenericObject?, stateData: Data?, actionSource: ActionSource, peer: Peer)
    case gotGreetings(PeerMetadata, initialState: GenericObject, initialStateData: Data, peer: Peer)
}
