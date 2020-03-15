import Combine
import CombineRex
import Counter
import FavoritePrimes
import SwiftRex
import SwiftUI

struct AppState: Equatable {
    var count = 0
    var favoritePrimes: [Int] = []
    var loggedInUser: User? = nil
    var activityFeed: [Activity] = []
    var alertNthPrime: PrimeAlert? = nil
    var isNthPrimeButtonDisabled: Bool = false
    var isPrimeModalShown: Bool = false

    struct Activity: Equatable {
        let timestamp: Date
        let type: ActivityType

        enum ActivityType: Equatable {
            case addedFavoritePrime(Int)
            case removedFavoritePrime(Int)
        }
    }

    struct User: Equatable {
        let id: Int
        let name: String
        let bio: String
    }
}

enum AppAction {
    case counterView(CounterViewAction)
    case favoritePrimes(FavoritePrimesAction)
}

extension AppState {
    var counterView: CounterViewState {
        get {
            CounterViewState(
                alertNthPrime: self.alertNthPrime,
                count: self.count,
                favoritePrimes: self.favoritePrimes,
                isNthPrimeButtonDisabled: self.isNthPrimeButtonDisabled,
                isPrimeModalShown: self.isPrimeModalShown
            )
        }
        set {
            self.alertNthPrime = newValue.alertNthPrime
            self.count = newValue.count
            self.favoritePrimes = newValue.favoritePrimes
            self.isNthPrimeButtonDisabled = newValue.isNthPrimeButtonDisabled
            self.isPrimeModalShown = newValue.isPrimeModalShown
        }
    }
}

import CasePaths

func setter<Root, Value>(_ keyPath: WritableKeyPath<Root, Value>) -> (inout Root, Value) -> Void {
    return { root, value in
        root[keyPath: keyPath] = value
    }
}

let appReducer: Reducer<AppAction, AppState> =
    counterViewReducer.lift(
        actionGetter: /AppAction.counterView,
        stateGetter: { $0.counterView },
        stateSetter: setter(\AppState.counterView)
    ) <> favoritePrimesReducer.lift(
        actionGetter: /AppAction.favoritePrimes,
        stateGetter: { $0.favoritePrimes },
        stateSetter: setter(\AppState.favoritePrimes)
    )

let appMiddleware: ComposedMiddleware<AppAction, AppAction, AppState> =
    CounterMiddleware().lift(
        inputActionMap: (/AppAction.counterView .. /CounterViewAction.counter).extract,
        outputActionMap: (/AppAction.counterView .. /CounterViewAction.counter).embed,
        stateMap: { $0.count }
    )
    <> FavoritePrimesMiddleware().lift(
        inputActionMap: (/AppAction.favoritePrimes).extract,
        outputActionMap: (/AppAction.favoritePrimes).embed,
        stateMap: { $0.favoritePrimes }
    )


//func activityFeed(
//    _ reducer: @escaping Reducer<AppState, AppAction>
//) -> Reducer<AppState, AppAction> {
//
//    return { state, action in
//        switch action {
//        case .counterView(.counter),
//             .favoritePrimes(.loadedFavoritePrimes),
//             .favoritePrimes(.loadButtonTapped),
//             .favoritePrimes(.saveButtonTapped):
//            break
//        case .counterView(.primeModal(.removeFavoritePrimeTapped)):
//            state.activityFeed.append(.init(timestamp: Date(), type: .removedFavoritePrime(state.count)))
//
//        case .counterView(.primeModal(.saveFavoritePrimeTapped)):
//            state.activityFeed.append(.init(timestamp: Date(), type: .addedFavoritePrime(state.count)))
//
//        case let .favoritePrimes(.deleteFavoritePrimes(indexSet)):
//            for index in indexSet {
//                state.activityFeed.append(.init(timestamp: Date(), type: .removedFavoritePrime(state.favoritePrimes[index])))
//            }
//        }
//
//        return reducer(&state, action)
//    }
//}

struct ContentView: View {
    @ObservedObject var store: ObservableViewModel<AppAction, AppState>

    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    "Counter demo",
                    destination: CounterView(
                        store: self.store.projection(
                            action: { .counterView($0) },
                            state: { $0.counterView }
                        ).asObservableViewModel(initialState: .init(), emitsValue: .whenDifferent)
                    )
                )
                NavigationLink(
                    "Favorite primes",
                    destination: FavoritePrimesView(
                        store: self.store.projection(
                            action: { .favoritePrimes($0) },
                            state: { $0.favoritePrimes }
                        ).asObservableViewModel(initialState: .init(), emitsValue: .whenDifferent)
                    )
                )
            }
            .navigationBarTitle("State management")
        }
    }
}
