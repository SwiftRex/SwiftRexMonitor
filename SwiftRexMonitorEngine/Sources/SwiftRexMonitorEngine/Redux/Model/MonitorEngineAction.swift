import Foundation
import MultipeerMiddleware

// sourcery: EnumCodable=EncodeOnly
// sourcery: Prism
public enum MonitorEngineAction {
    case start
    case monitor(MonitorAction)
    case multipeer(MultipeerAction)
}
