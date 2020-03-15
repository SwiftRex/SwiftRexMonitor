import Foundation
import MultipeerConnectivity

// sourcery: EnumCodable=EncodeOnly
// sourcery: Prism
public enum MultipeerAdvertiserAction {
    case startAdvertising
    case startedAdvertising
    case stopAdvertising
    case stoppedAdvertising
    case stoppedAdvertisingDueToError(/* sourcery: CustomEncoder=encodeError */ Error)
    case invited(by: Peer, context: Data?)
    case acceptedInvitation(from: Peer, context: Data?)
    case declinedInvitation(from: Peer, context: Data?)

    func encodeError(_ error: Error) -> String {
        error.localizedDescription
    }
}
