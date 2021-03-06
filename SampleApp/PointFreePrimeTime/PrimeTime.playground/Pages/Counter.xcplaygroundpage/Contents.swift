import Combine
import CombineRex
@testable import Counter
import PlaygroundSupport
import SwiftUI

Current = .mock
Current.nthPrime = { _ in .sync { 7236893748932 } }

PlaygroundPage.current.liveView = UIHostingController(
    rootView: CounterView(
        store: Store<CounterViewState, CounterViewAction>(
            initialValue: CounterViewState(
                alertNthPrime: nil,
                count: 0,
                favoritePrimes: [],
                isNthPrimeButtonDisabled: false
            ),
            reducer: logging(counterViewReducer)
        )
    )
)
