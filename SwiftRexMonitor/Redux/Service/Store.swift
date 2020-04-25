import CombineRex
import Foundation
import LoggerMiddleware
import MultipeerMiddleware
import SwiftRex

private let appMiddleware = { (world: World) -> ComposedMiddleware<AppAction, AppAction, AppState> in
    let peer = world.myselfAsPeer()
    let session = world.multipeerSession

    return
        LoggerMiddleware
            .init(
                actionTransform: { "\n🕹 \($0)\n🎪 \($1.file.split(separator: "/").last ?? ""):\($1.line) \($1.function)" },
                stateDiffPrinter: { print("\($0 ?? "🏛 No state changes")") })
            .lift(
                inputActionMap: identity,
                outputActionMap: absurd,
                stateMap: identity
            )

        <> MultipeerBridgeMonitorMiddleware()
            .lift(
                inputActionMap: identity,
                outputActionMap: identity,
                stateMap: ignore
            )

        <> MonitorMiddleware
            .init(
                multipeerSession: session,
                decoder: JSONDecoder.init
            )
            .lift(
                inputActionMap: \AppAction.monitor,
                outputActionMap: AppAction.monitor,
                stateMap: \AppState.monitoredPeers
            )

        <> MultipeerBrowserMiddleware
            .init(browser: { world.browserPublisher(peer) }, session: session)
            .lift(
                inputActionMap: \AppAction.multipeer?.browser,
                outputActionMap: { x in AppAction.multipeer(.browser(x)) },
                stateMap: \AppState.multipeer.browser
            )

        <> MultipeerMessagingMiddleware
            .init(session: session)
            .lift(
                inputActionMap: \AppAction.multipeer?.messaging,
                outputActionMap: { x in AppAction.multipeer(.messaging(x)) },
                stateMap: ignore(of: AppState.self)
            )

//        <> MultipeerAdvertiserMiddleware
//            .init(advertiser: { world.advertiserPublisher(peer) }, session: session)
//            .lift(
//                inputActionMap: \AppAction.multipeer?.advertiser,
//                outputActionMap: { x in AppAction.multipeer(.advertiser(x)) },
//                stateMap: \AppState.multipeer.advertiser
//            )

        <> MultipeerConnectivityMiddleware
            .init(session: session)
            .lift(
                inputActionMap: \AppAction.multipeer?.connectivity,
                outputActionMap: { x in AppAction.multipeer(.connectivity(x)) },
                stateMap: ignore(of: AppState.self)
            )
}

private let appReducer =
    MultipeerMiddleware.multipeerBrowserReducer.lift(
        actionGetter: \AppAction.multipeer?.browser,
        stateGetter: \AppState.multipeer.browser,
        stateSetter: setter(\AppState.multipeer.browser)
    )
    <> monitorReducer.lift(
        actionGetter: \AppAction.monitor,
        stateGetter: \AppState.monitoredPeers,
        stateSetter: setter(\AppState.monitoredPeers)
    )

func createStore(world: World) -> AnyStoreType<AppAction, AppState> {
    Store(initialState: .empty, middleware: appMiddleware(world), reducer: appReducer).eraseToAnyStoreType()
}

public class Store: ReduxStoreBase<AppAction, AppState> {
    public init<M: Middleware>(initialState: AppState, middleware: M, reducer: Reducer<AppAction, AppState>)
    where M.InputActionType == AppAction, M.OutputActionType == AppAction, M.StateType == AppState {
        super.init(
            subject: .combine(initialValue: initialState),
            reducer: reducer,
            middleware: middleware,
            emitsValue: .whenDifferent
        )
    }
}
