import Foundation
import SwiftRexMonitorEngine

// sourcery: EnumCodable=EncodeOnly
// sourcery: Prism
enum AppAction {
    case monitorEngine(MonitorEngineAction)
    case pasteboard(PasteboardAction)
    case router(RouterAction)
}

// sourcery: EnumCodable=EncodeOnly
// sourcery: Prism
enum RouterAction {
    case changeAppSelection(Int?)
}

// sourcery: EnumCodable=EncodeOnly
// sourcery: Prism
enum PasteboardAction {
    case copy(String)
}
