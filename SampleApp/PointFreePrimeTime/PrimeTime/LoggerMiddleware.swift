import Combine
import Foundation
import os.log
import SwiftRex

final class LoggerMiddleware: Middleware {
    typealias InputActionType = AppAction
    typealias OutputActionType = Never
    typealias StateType = AppState

    private var getState: GetState<StateType>!
    private var cancellables = Set<AnyCancellable>()
    private let actionPrint: (AppAction) -> String?
    private let statePrint: (AppState) -> String?

    init(actionPrint: @escaping (AppAction) -> String? = { "\($0)" }, statePrint: @escaping (AppState) -> String? = { "\($0)" }) {
        self.actionPrint = actionPrint
        self.statePrint = statePrint
    }

    func receiveContext(getState: @escaping GetState<StateType>, output: AnyActionHandler<OutputActionType>) {
        self.getState = getState
    }

    func handle(action: InputActionType, from dispatcher: ActionSource, afterReducer: inout AfterReducer) {
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
