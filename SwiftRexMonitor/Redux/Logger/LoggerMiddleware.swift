//
//  LoggerMiddleware.swift
//  SwiftRexMonitor
//
//  Created by Luiz Rodrigo Martins Barbosa on 15.03.20.
//  Copyright © 2020 DeveloperCity. All rights reserved.
//

import Combine
import Foundation
import os.log
import SwiftRex

public final class LoggerMiddleware: Middleware {
    public typealias InputActionType = AppAction
    public typealias OutputActionType = Never
    public typealias StateType = AppState

    private var getState: GetState<StateType>!
    private var cancellables = Set<AnyCancellable>()
    private let actionPrint: (AppAction) -> String?
    private let statePrint: (AppState) -> String?

    public init(actionPrint: @escaping (AppAction) -> String? = { "\($0)" }, statePrint: @escaping (AppState) -> String? = { "\($0)" }) {
        self.actionPrint = actionPrint
        self.statePrint = statePrint
    }

    public func receiveContext(getState: @escaping GetState<StateType>, output: AnyActionHandler<OutputActionType>) {
        self.getState = getState
    }

    public func handle(action: InputActionType, from dispatcher: ActionSource, afterReducer: inout AfterReducer) {
        let stateBefore = getState()
        afterReducer = .do {
            let stateAfter = self.getState()

            var enabled = false
            if let actionString = self.actionPrint(action) {
                enabled = true
                let message = "🕹 \(actionString) from \(dispatcher)"
                os_log(.debug, log: .default, "%{PUBLIC}@", message)
            }

            if stateBefore != stateAfter, let stateString = self.statePrint(stateAfter) {
                enabled = true
                os_log(.debug, log: .default, "🏛 %{PUBLIC}@", stateString)
            } else {
                os_log(.debug, log: .default, "🏛 No state mutation")
            }

            if enabled {
                os_log(.debug, log: .default, "")
            }
        }
    }
}
