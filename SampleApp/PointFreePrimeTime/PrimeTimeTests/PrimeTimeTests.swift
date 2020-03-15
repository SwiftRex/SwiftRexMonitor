import XCTest
import CombineRex
@testable import PrimeTime
import SwiftRex
@testable import Counter

class PrimeTimeTests: XCTestCase {
    func testExample() {
        let store = ReduxStoreBase<AppAction, AppState>(
            subject: .combine(initialValue: .init(
                count: 2,
                favoritePrimes: [2, 3, 5],
                loggedInUser: nil,
                activityFeed: [],
                alertNthPrime: nil,
                isNthPrimeButtonDisabled: false,
                isPrimeModalShown: false
            )),
            reducer: appReducer,
            middleware: appMiddleware,
            emitsValue: .whenDifferent
        )

        let c = CounterView(
            store: store.projection(
                action: AppAction.counterView,
                state: { $0.counterView }
            ).asObservableViewModel(initialState: .init())
        )

        let cc = ContentView(store: store.asObservableViewModel(initialState: .init()))

        print(c.body)
        let tmp = c.body
        print(type(of: tmp))

        print(cc.body)
        let tmp1 = cc.body
        print(type(of: tmp1))
    }

}
