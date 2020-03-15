import Foundation

// sourcery: EnumCodable
public enum MessageType: Equatable {
    case introduction(PeerMetadata)
    case action(ActionMessage)
}
