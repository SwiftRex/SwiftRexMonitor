import CombineRex
import Foundation
import MonitoredAppMiddleware
import SwiftRex
import SwiftRexMonitorEngine

enum AppMonitorPresenter: Presenter {
    typealias ViewEvent = AppMonitorEvent
    typealias ViewState = AppMonitorState
    typealias State = MonitoredPeer?
    typealias Action = AppAction
    typealias RouterState = Void
    typealias Dependencies = Void

    static func handleEvent(dependencies: Void) -> ((ViewEvent) -> Action?) {
        return { _ in nil }
    }

    static func handleState(dependencies: Void, router: ViewProducer<Void>) -> ((State) -> ViewState) {
        return { state in
            state.map { state in
                AppMonitorState(
                    id: state.peer.peerInstance.hash,
                    name: state.metadata?.monitoredApp.appName ?? state.peer.peerInstance.displayName,
                    state: state.history.last?.state ?? .null,
                    isValid: true
                )
            } ?? .empty
        }
    }
}

enum AppMonitorEvent {
}

struct AppMonitorState: Equatable, Emptyable {
    let id: Int
    let name: String
    let state: GenericObject
    let isValid: Bool

    static var empty: AppMonitorState {
        .init(id: 0, name: "", state: .null, isValid: false)
    }
}
