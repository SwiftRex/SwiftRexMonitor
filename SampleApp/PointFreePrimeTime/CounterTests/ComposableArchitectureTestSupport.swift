import Combine
import CombineRex
@testable import SwiftRex
import XCTest

enum StepType {
    case send
    case receive
}

struct Step<Value, Action> {
    let type: StepType
    let action: Action
    let update: (inout Value) -> Void
    let file: StaticString
    let line: UInt

    init(
        _ type: StepType,
        _ action: Action,
        file: StaticString = #file,
        line: UInt = #line,
        _ update: @escaping (inout Value) -> Void
    ) {
        self.type = type
        self.action = action
        self.update = update
        self.file = file
        self.line = line
    }
}

func assert<M: Middleware>(
    initialValue: M.StateType,
    reducer: Reducer<M.InputActionType, M.StateType>,
    middleware: M,
    steps: Step<M.StateType, M.InputActionType>...,
    file: StaticString = #file,
    line: UInt = #line
) where M.InputActionType == M.OutputActionType, M.InputActionType: Equatable, M.StateType: Equatable {
    var state = initialValue
    var middlewareResponses: [M.OutputActionType] = []
    let gotAction = XCTestExpectation(description: "got action")
    gotAction.assertForOverFulfill = false
    let anyActionHandler = AnyActionHandler<M.OutputActionType>.init { (action, _) in
        middlewareResponses.append(action)
        gotAction.fulfill()
    }
    middleware.receiveContext(getState: { state }, output: anyActionHandler)

    steps.forEach { step in
        var expected = state

        switch step.type {
        case .send:
            if !middlewareResponses.isEmpty {
                XCTFail("Action sent before handling \(middlewareResponses.count) pending effect(s)", file: step.file, line: step.line)
            }
            var afterReducer: AfterReducer = .doNothing()
            middleware.handle(
                action: step.action,
                from: .init(file: "\(step.file)", function: "", line: step.line, info: nil),
                afterReducer: &afterReducer
            )
            state = reducer.reduce(step.action, state)
            afterReducer.reducerIsDone()
        case .receive:
            if middlewareResponses.isEmpty {
                _ = XCTWaiter.wait(for: [gotAction], timeout: 0.2)
            }
            guard !middlewareResponses.isEmpty else {
                XCTFail("No pending effects to receive from", file: step.file, line: step.line)
                break
            }
            let first = middlewareResponses.removeFirst()
            XCTAssertEqual(first, step.action, file: step.file, line: step.line)
            var afterReducer: AfterReducer = .doNothing()
            middleware.handle(
                action: step.action,
                from: .init(file: "\(step.file)", function: "", line: step.line, info: nil),
                afterReducer: &afterReducer
            )
            state = reducer.reduce(step.action, state)
            afterReducer.reducerIsDone()
        }

        step.update(&expected)
        XCTAssertEqual(state, expected, file: step.file, line: step.line)
    }

    if !middlewareResponses.isEmpty {
        XCTFail("Assertion failed to handle \(middlewareResponses.count) pending effect(s)", file: file, line: line)
    }
}
