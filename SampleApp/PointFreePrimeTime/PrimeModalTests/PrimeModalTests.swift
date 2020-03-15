import XCTest
@testable import PrimeModal
@testable import SwiftRex

class PrimeModalTests: XCTestCase {
    func testSaveFavoritesPrimesTapped() {
        var state = (count: 2, favoritePrimes: [3, 5])
        state = primeModalReducer.reduce(.saveFavoritePrimeTapped, state)

        let (count, favoritePrimes) = state
        XCTAssertEqual(count, 2)
        XCTAssertEqual(favoritePrimes, [3, 5, 2])
    }

    func testRemoveFavoritesPrimesTapped() {
        var state = (count: 3, favoritePrimes: [3, 5])
        state = primeModalReducer.reduce(.removeFavoritePrimeTapped, state)

        let (count, favoritePrimes) = state
        XCTAssertEqual(count, 3)
        XCTAssertEqual(favoritePrimes, [5])
    }
}
