import Combine
import Foundation
import SwiftRex

public typealias PrimeModalState = (count: Int, favoritePrimes: [Int])

public enum PrimeModalAction: Equatable {
    case saveFavoritePrimeTapped
    case removeFavoritePrimeTapped
}

public let primeModalReducer = Reducer<PrimeModalAction, PrimeModalState> { action, state in
    switch action {
    case .removeFavoritePrimeTapped:
        var state = state
        state.favoritePrimes.removeAll(where: { $0 == state.count })
        return state

    case .saveFavoritePrimeTapped:
        var state = state
        state.favoritePrimes.append(state.count)
        return state
    }
}

import CombineRex
import SwiftUI

public struct IsPrimeModalView: View {
    @ObservedObject var store: ObservableViewModel<PrimeModalAction, PrimeModalState>

    public init(store: ObservableViewModel<PrimeModalAction, PrimeModalState>) {
        self.store = store
    }

    public var body: some View {
        VStack {
            if isPrime(self.store.state.count) {
                Text("\(self.store.state.count) is prime 🎉")
                if self.store.state.favoritePrimes.contains(self.store.state.count) {
                    Button("Remove from favorite primes") {
                        self.store.dispatch(.removeFavoritePrimeTapped)
                    }
                } else {
                    Button("Save to favorite primes") {
                        self.store.dispatch(.saveFavoritePrimeTapped)
                    }
                }
            } else {
                Text("\(self.store.state.count) is not prime :(")
            }
        }
    }
}

func isPrime(_ p: Int) -> Bool {
    if p <= 1 { return false }
    if p <= 3 { return true }
    for i in 2...Int(sqrtf(Float(p))) where p % i == 0 {
        return false
    }
    return true
}
