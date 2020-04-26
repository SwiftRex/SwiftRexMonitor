import Foundation
import SwiftRexMonitorEngine

struct AppState: Encodable, Equatable {
    var monitorEngine: MonitorEngineState
}

extension AppState {
    static var empty: AppState {
        .init(monitorEngine: .empty)
    }
}
