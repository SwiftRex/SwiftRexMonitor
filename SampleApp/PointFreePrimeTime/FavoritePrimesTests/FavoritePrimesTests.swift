import XCTest
@testable import FavoritePrimes
@testable import SwiftRex

class FavoritePrimesTests: XCTestCase {
    var state: [Int] = []
    var middlewareActions: [FavoritePrimesAction] = []
    var middleware = FavoritePrimesMiddleware()
    var afterReducer: AfterReducer = .doNothing()

    override class func setUp() {
        super.setUp()
        Current = .mock
    }

    override func setUp() {
        super.setUp()
        middlewareActions = []
        state = [2, 3, 5, 7]
        afterReducer = .doNothing()
        middleware = FavoritePrimesMiddleware()
        let actionHandler = AnyActionHandler<FavoritePrimesAction>.init { action, _ in
            self.middlewareActions.append(action)
        }
        middleware.receiveContext(getState: { self.state }, output: actionHandler)
    }

    func testDeleteFavoritePrimes() {
        let action = FavoritePrimesAction.deleteFavoritePrimes([2])

        handle(action: action)

        XCTAssertEqual(state, [2, 3, 7])
        XCTAssert(middlewareActions.isEmpty)
    }

    func testSaveButtonTapped() {
        let action = FavoritePrimesAction.saveButtonTapped
        var didSave = false
        Current.fileClient.save = { _, data in
            .fireAndForget {
                didSave = true
            }
        }

        handle(action: action)

        XCTAssertEqual(state, [2, 3, 5, 7])
        XCTAssertEqual(middlewareActions.count, 0)

        XCTAssert(didSave)
    }

    func testLoadFavoritePrimesFlow() {
        let action = FavoritePrimesAction.loadButtonTapped
        Current.fileClient.load = { _ in .sync { try! JSONEncoder().encode([2, 31]) } }

        handle(action: action)

        XCTAssertEqual(state, [2, 3, 5, 7])

        XCTAssertEqual(middlewareActions.count, 1)
        let nextAction = middlewareActions.removeFirst()
        XCTAssertEqual(nextAction, .loadedFavoritePrimes([2, 31]))

        handle(action: nextAction)

        XCTAssertEqual(state, [2, 31])
        XCTAssert(middlewareActions.isEmpty)
    }

    func handle(action: FavoritePrimesAction) {
        afterReducer = .doNothing()
        middleware.handle(action: action, from: .here(), afterReducer: &afterReducer)
        state = favoritePrimesReducer.reduce(action, state)
        afterReducer.reducerIsDone()
    }
}
