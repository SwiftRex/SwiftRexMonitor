//
//  Presenter.swift
//  SwiftRexMonitor
//
//  Created by Luiz Rodrigo Martins Barbosa on 27.04.20.
//  Copyright © 2020 DeveloperCity. All rights reserved.
//

import CombineRex
import Foundation
import SwiftRex

public protocol Presenter {
    associatedtype ViewEvent
    associatedtype ViewState: Equatable & Emptyable
    associatedtype State
    associatedtype Action
    associatedtype Dependencies
    typealias ViewModel = ObservableViewModel<ViewEvent, ViewState>

    static func handleEvent(dependencies: Dependencies) -> ((ViewEvent) -> Action?)
    static func handleState(dependencies: Dependencies) -> ((State) -> ViewState)
}

extension Presenter {
    public static func viewModel<S: StoreType>(dependencies: Dependencies, store: S) -> ObservableViewModel<ViewEvent, ViewState>
        where S.ActionType == Action, S.StateType == State {
            store.projection(
                action: self.handleEvent(dependencies: dependencies),
                state: self.handleState(dependencies: dependencies)
            ).asObservableViewModel(
                initialState: .empty,
                emitsValue: .whenDifferent
            )
    }
}
