import SwiftRex

enum PasteboardService {
    static let middleware = PasteboardMiddleware.init
}

class PasteboardMiddleware: Middleware {
    typealias InputActionType = PasteboardAction
    typealias OutputActionType = Never
    typealias StateType = Void

    private let copy: (String) -> Void
    init(copy: @escaping (String) -> Void) {
        self.copy = copy
    }

    func receiveContext(getState: @escaping GetState<Void>, output: AnyActionHandler<Never>) {
    }

    func handle(action: PasteboardAction, from dispatcher: ActionSource, afterReducer: inout AfterReducer) {
        switch action {
        case let .copy(string):
            copy(string)
        }
    }
}
