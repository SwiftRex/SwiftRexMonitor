import Foundation
import SwiftRexMonitorEngine

struct AppState: Encodable, Equatable {
    var monitorEngine: MonitorEngineState
    var navigationTree: NavigationTree
}

extension AppState {
    static var empty: AppState {
        .init(monitorEngine: .empty, navigationTree: .empty)
    }
}

// sourcery: Prism
// sourcery: EnumCodable
enum NavigationTree: Equatable, Emptyable {
    case home(selectedPeer: Int?)

    static var empty: NavigationTree {
        .home(selectedPeer: nil)
    }
}
