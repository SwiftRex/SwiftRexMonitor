import Foundation
import SwiftRexMonitorEngine

// sourcery: EnumCodable=EncodeOnly
// sourcery: Prism
enum AppAction {
    case monitorEngine(MonitorEngineAction)
}
