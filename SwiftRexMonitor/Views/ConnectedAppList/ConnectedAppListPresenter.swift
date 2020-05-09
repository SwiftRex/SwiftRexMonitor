import CombineRex
import Foundation
import SwiftRex
import SwiftRexMonitorEngine

enum ConnectedAppListPresenter: Presenter {
    typealias ViewEvent = ConnectedAppListEvent
    typealias ViewState = ConnectedAppListState
    typealias State = AppState
    typealias Action = AppAction
    typealias RouterState = Void
    typealias Dependencies = Void

    static func handleEvent(dependencies: Void) -> ((ViewEvent) -> Action?) {
        return { event in
            switch event {
            case let .changeAppSelection(newSelection):
                return .router(.changeAppSelection(newSelection))
            case let .copy(string):
                return .pasteboard(.copy(string))
            }
        }
    }

    static func handleState(dependencies: Void, router: ViewProducer<RouterState>) -> ((State) -> ViewState) {
        return { state in
            ConnectedAppListState(
                header: "Connected apps",
                selectedApp: state.navigationTree.home.flatMap(identity),
                apps: state.monitorEngine.monitoredPeers.map { monitoredPeer in
                    .init(
                        id: monitoredPeer.id,
                        name: formatName(monitoredPeer: monitoredPeer),
                        state: monitoredPeer.history.last?.state.debugDescription ?? "",
                        stringForPasteboard: monitoredPeer.history.last?
                            .stateData
                            .flatMap { String(data: $0, encoding: .utf8) } ?? ""
                    )
                },
                router: router,
                jsonButtonCaption: "JSON"
            )
        }
    }

    static func formatName(monitoredPeer: MonitoredPeer) -> String {
        if let appName = monitoredPeer.metadata?.monitoredApp.appName, let device = monitoredPeer.metadata?.monitoredDevice.deviceName {
            return "\(appName) @ \(device)"
        } else {
            return monitoredPeer.peer.peerInstance.displayName
        }
    }
}

enum ConnectedAppListEvent {
    case changeAppSelection(Int?)
    case copy(String)
}

struct ConnectedAppListState: Equatable, Emptyable {
    let header: String
    let selectedApp: Int?
    let apps: [ConnectedAppState]
    let router: ViewProducer<Void>
    let jsonButtonCaption: String

    static var empty: ConnectedAppListState {
        .init(header: "", selectedApp: nil, apps: [], router: .empty, jsonButtonCaption: "")
    }

    struct ConnectedAppState: Equatable, Emptyable, Identifiable {
        let id: Int
        let name: String
        let state: String
        let stringForPasteboard: String

        static var empty: ConnectedAppState {
            .init(id: 0, name: "", state: "", stringForPasteboard: "")
        }
    }
}
