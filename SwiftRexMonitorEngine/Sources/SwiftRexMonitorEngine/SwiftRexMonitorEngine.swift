//
//  File.swift
//  
//
//  Created by Luiz Rodrigo Martins Barbosa on 26.04.20.
//

import Foundation
import MultipeerCombine
import MultipeerMiddleware
import SwiftRex

public enum SwiftRexMonitorEngine {
    public static func middleware(
        multipeerSession: @escaping () -> MultipeerSession,
        browser: @escaping () -> MultipeerBrowserPublisher,
        decoder: @escaping () -> JSONDecoder
    ) -> ComposedMiddleware<MonitorEngineAction, MonitorEngineAction, MonitorEngineState> {
        [
            MultipeerBridgeMonitorMiddleware
                .init()
                .lift(
                    inputActionMap: identity,
                    outputActionMap: identity,
                    stateMap: ignore
                )
                .eraseToAnyMiddleware(),

            MonitorMiddleware
                .init(multipeerSession: multipeerSession, decoder: decoder)
                .lift(
                    inputActionMap: \MonitorEngineAction.monitor,
                    outputActionMap: MonitorEngineAction.monitor,
                    stateMap: \MonitorEngineState.monitoredPeers
                )
                .eraseToAnyMiddleware(),

            MultipeerBrowserMiddleware
                .init(browser: browser, session: multipeerSession)
                .lift(
                    inputActionMap: \MonitorEngineAction.multipeer?.browser,
                    outputActionMap: { x in MonitorEngineAction.multipeer(.browser(x)) },
                    stateMap: \MonitorEngineState.multipeer.browser
                )
                .eraseToAnyMiddleware(),

            MultipeerMessagingMiddleware
                .init(session: multipeerSession)
                .lift(
                    inputActionMap: \MonitorEngineAction.multipeer?.messaging,
                    outputActionMap: { x in MonitorEngineAction.multipeer(.messaging(x)) },
                    stateMap: ignore(of: MonitorEngineState.self)
                )
                .eraseToAnyMiddleware(),

            MultipeerConnectivityMiddleware
                .init(session: multipeerSession)
                .lift(
                    inputActionMap: \MonitorEngineAction.multipeer?.connectivity,
                    outputActionMap: { x in MonitorEngineAction.multipeer(.connectivity(x)) },
                    stateMap: ignore(of: MonitorEngineState.self)
                )
                .eraseToAnyMiddleware()
        ]
        .reduce(into: ComposedMiddleware<MonitorEngineAction, MonitorEngineAction, MonitorEngineState>(), { $0.append(middleware: $1) })
    }

    public static let reducer: Reducer<MonitorEngineAction, MonitorEngineState> = [
        MultipeerMiddleware.multipeerBrowserReducer.lift(
            actionGetter: \MonitorEngineAction.multipeer?.browser,
            stateGetter: \MonitorEngineState.multipeer.browser,
            stateSetter: setter(\MonitorEngineState.multipeer.browser)
        ),

        monitorReducer.lift(
            actionGetter: \MonitorEngineAction.monitor,
            stateGetter: \MonitorEngineState.monitoredPeers,
            stateSetter: setter(\MonitorEngineState.monitoredPeers)
        )
    ].reduce(Reducer.identity, <>)
}
