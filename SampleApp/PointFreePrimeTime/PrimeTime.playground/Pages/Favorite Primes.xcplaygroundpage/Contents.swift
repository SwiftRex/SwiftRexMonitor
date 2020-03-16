import Combine
import CombineRex
@testable import FavoritePrimes
import PlaygroundSupport
import SwiftUI

Current = .mock
Current.fileClient.load = { _ in
    AnyPublisher.sync { try! JSONEncoder().encode(Array(1...1000)) } // swiftlint:disable:this force_try
}

PlaygroundPage.current.liveView = UIHostingController(
    rootView: NavigationView {
        FavoritePrimesView(
            store: StoreProjection<FavoritePrimesAction, [Int]>(
                initialValue: [2, 3, 5, 7, 11],
                reducer: favoritePrimesReducer
            )
        )
    }
)
