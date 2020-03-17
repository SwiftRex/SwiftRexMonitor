import Foundation
import MultipeerMiddleware

// sourcery: EnumCodable=EncodeOnly
// sourcery: Prism
public enum AppAction {
    case start
    case monitor(MonitorAction)
    case multipeer(MultipeerAction)
}
