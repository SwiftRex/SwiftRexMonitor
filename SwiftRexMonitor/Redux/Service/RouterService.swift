import SwiftRex

extension Reducer where ActionType == RouterAction, StateType == AppState {
    static let routerReducer = Reducer { action, state in
        switch action {
        case let .changeAppSelection(newSelection):
            var state = state
            let selection = state.monitorEngine.monitoredPeers.first(where: { $0.id == newSelection })?.id
            state.navigationTree = .home(selectedPeer: selection)
            return state
        }
    }
}
