import CombineRex
import Foundation
import LoggerMiddleware
import MultipeerMiddleware
import SwiftRex
import SwiftRexMonitorEngine

private let appMiddleware = { (world: World) -> ComposedMiddleware<AppAction, AppAction, AppState> in
    let peer = world.myselfAsPeer()
    let session = world.multipeerSession

    return [
        LoggerMiddleware
            .init(
                actionTransform: { "\n🕹 \($0)\n🎪 \($1.file.split(separator: "/").last ?? ""):\($1.line) \($1.function)" },
                stateDiffPrinter: { print("\($0 ?? "🏛 No state changes")") })
            .lift(
                inputActionMap: identity,
                outputActionMap: absurd,
                stateMap: identity
            )
            .eraseToAnyMiddleware(),

        PasteboardService
            .middleware(world.copy)
            .lift(
                inputActionMap: \AppAction.pasteboard,
                outputActionMap: absurd,
                stateMap: ignore
            ).eraseToAnyMiddleware(),

        SwiftRexMonitorEngine
            .middleware(multipeerSession: world.multipeerSession, browser: { world.browserPublisher(peer) }, decoder: world.decoder)
            .lift(
                inputActionMap: \AppAction.monitorEngine,
                outputActionMap: AppAction.monitorEngine,
                stateMap: \AppState.monitorEngine
            )
            .eraseToAnyMiddleware()
    ].reduce(into: ComposedMiddleware<AppAction, AppAction, AppState>(), { $0.append(middleware: $1) })
}

private let appReducer = SwiftRexMonitorEngine.reducer.lift(
    actionGetter: \AppAction.monitorEngine,
    stateGetter: \AppState.monitorEngine,
    stateSetter: setter(\AppState.monitorEngine)
) <> Reducer.routerReducer.lift(action: \.router)

func createStore(world: World) -> AnyStoreType<AppAction, AppState> {
    Store(initialState: .empty, middleware: appMiddleware(world), reducer: appReducer).eraseToAnyStoreType()
}

class Store: ReduxStoreBase<AppAction, AppState> {
    init<M: Middleware>(initialState: AppState, middleware: M, reducer: Reducer<AppAction, AppState>)
    where M.InputActionType == AppAction, M.OutputActionType == AppAction, M.StateType == AppState {
        super.init(
            subject: .combine(initialValue: initialState),
            reducer: reducer,
            middleware: middleware,
            emitsValue: .whenDifferent
        )
    }
}
