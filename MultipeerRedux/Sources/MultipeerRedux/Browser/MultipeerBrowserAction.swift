import Foundation
import MultipeerConnectivity

// sourcery: EnumCodable=EncodeOnly
// sourcery: Prism
public enum MultipeerBrowserAction {
    case startBrowsing
    case stopBrowsing
    case startedBrowsing
    case stoppedBrowsing
    case stoppedBrowsingDueToError(/* sourcery: CustomEncoder=encodeError */ Error)
    case foundPeer(Peer, info: [String: String]?, /* sourcery: CustomEncoder=encodeBrowser */ browser: MCNearbyServiceBrowser)
    case lostPeer(Peer)
    case manuallyInvite(Peer, /* sourcery: CustomEncoder=encodeBrowser */ browser: MCNearbyServiceBrowser)
    case didSendInvitation(Peer)
    case remoteAcceptedInvitation(Peer)
    case remoteDeclinedInvitation(Peer, /* sourcery: CustomEncoder=encodeError */ error: Error)

    func encodeBrowser(_ browser: MCNearbyServiceBrowser) -> String {
        ""
    }

    func encodeError(_ error: Error) -> String {
        error.localizedDescription
    }
}
