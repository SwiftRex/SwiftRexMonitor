import Foundation
import SwiftRex

let activityFeedReducer = Reducer<AppAction, AppState> { action, state in
    var state = state
    switch action {
    case .counterView(.counter),
         .favoritePrimes(.loadedFavoritePrimes),
         .favoritePrimes(.loadButtonTapped),
         .favoritePrimes(.saveButtonTapped):
        break
    case .counterView(.primeModal(.removeFavoritePrimeTapped)):
        state.activityFeed.append(.init(timestamp: Date(), type: .removedFavoritePrime(state.count)))

    case .counterView(.primeModal(.saveFavoritePrimeTapped)):
        state.activityFeed.append(.init(timestamp: Date(), type: .addedFavoritePrime(state.count)))

    case let .favoritePrimes(.deleteFavoritePrimes(indexSet)):
        for index in indexSet {
            state.activityFeed.append(.init(timestamp: Date(), type: .removedFavoritePrime(state.favoritePrimes[index])))
        }
    }
    return state
}
