//
//  HomePresenter.swift
//  SwiftRexMonitor
//
//  Created by Luiz Rodrigo Martins Barbosa on 27.04.20.
//  Copyright © 2020 DeveloperCity. All rights reserved.
//

import CombineRex
import SwiftRex

enum HomePresenter: Presenter {
    typealias ViewEvent = HomeViewEvent
    typealias ViewState = HomeViewState
    typealias State = AppState
    typealias Action = AppAction
    typealias Dependencies = Void

    static func handleEvent(dependencies: Void) -> ((ViewEvent) -> Action?) {
        return { _ in nil }
    }

    static func handleState(dependencies: Void) -> ((State) -> ViewState) {
        return { state in
            HomeViewState(
                title: "Connected apps",
                connectedApps: state.monitorEngine.monitoredPeers.map { monitoredPeer in
                    .init(
                        id: monitoredPeer.peer.peerInstance.hash,
                        name: monitoredPeer.metadata?.monitoredApp.appName ?? monitoredPeer.peer.peerInstance.displayName,
                        state: monitoredPeer.history.last?.state.debugDescription ?? ""
                    )
                }
            )
        }
    }
}

enum HomeViewEvent {
}

struct HomeViewState: Equatable, Emptyable {
    let title: String
    let connectedApps: [ConnectedApp]

    static var empty: HomeViewState {
        .init(title: "", connectedApps: [])
    }

    struct ConnectedApp: Equatable, Emptyable, Identifiable {
        let id: Int
        let name: String
        let state: String

        static var empty: HomeViewState.ConnectedApp {
            .init(id: 0, name: "", state: "")
        }
    }
}
