import CombineRex
import Foundation
import SwiftRex

enum HomePresenter: Presenter {
    typealias ViewEvent = HomeViewEvent
    typealias ViewState = HomeViewState
    typealias State = AppState
    typealias Action = AppAction
    typealias RouterState = NavigationTree
    typealias Dependencies = Void

    static func handleEvent(dependencies: Void) -> ((ViewEvent) -> Action?) {
        return { _ in nil }
    }

    static func handleState(dependencies: Void, router: ViewProducer<RouterState>) -> ((State) -> ViewState) {
        return { state in
            HomeViewState(
                router: router,
                tree: state.navigationTree
            )
        }
    }
}

enum HomeViewEvent {
}

struct HomeViewState: Equatable, Emptyable {
    let router: ViewProducer<NavigationTree>
    let tree: NavigationTree

    static var empty: HomeViewState {
        .init(router: .empty, tree: .empty)
    }
}
