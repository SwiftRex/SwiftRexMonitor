@testable import MonitoredAppMiddleware
import XCTest

final class MonitoredAppMiddlewareTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MonitoredAppMiddleware().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample)
    ]
}
