import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SwiftRexMonitorEngineTests.allTests),
    ]
}
#endif
