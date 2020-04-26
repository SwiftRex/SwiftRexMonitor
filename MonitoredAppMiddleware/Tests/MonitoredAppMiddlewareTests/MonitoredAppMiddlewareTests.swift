@testable import MonitoredAppMiddleware
import XCTest

final class MonitoredAppMiddlewareTests: XCTestCase {
    func testGenericObjectDecodeString() throws {
        let json = "{\"string\":\"my string\"}"
        let result = try JSONDecoder().decode(GenericObject.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(result, GenericObject.genericObject([.init(key: "string", value: .string("my string"))]))
    }

    func testGenericObjectDecodeInt() throws {
        let json = "{\"int\":42}"
        let result = try JSONDecoder().decode(GenericObject.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(result, GenericObject.genericObject([.init(key: "int", value: .int(42))]))
    }

    func testGenericObjectDecodeBoolTrue() throws {
        let json = "{\"bool\":true}"
        let result = try JSONDecoder().decode(GenericObject.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(result, GenericObject.genericObject([.init(key: "bool", value: .bool(true))]))
    }

    func testGenericObjectDecodeBoolFalse() throws {
        let json = "{\"bool\":false}"
        let result = try JSONDecoder().decode(GenericObject.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(result, GenericObject.genericObject([.init(key: "bool", value: .bool(false))]))
    }

    func testGenericObjectDecodeNull() throws {
        let json = "{\"something\":null}"
        let result = try JSONDecoder().decode(GenericObject.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(result, GenericObject.genericObject([.init(key: "something", value: .null)]))
    }

    func testGenericObjectDecodeDouble() throws {
        let json = "{\"double\":42.1}"
        let result = try JSONDecoder().decode(GenericObject.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(result, GenericObject.genericObject([.init(key: "double", value: .double(42.1))]))
    }

    func testGenericObjectDecodeArrayOfInts() throws {
        let json = "{\"ints\":[1, 2, 3, 5, 8, 13, 21, 34, 55]}"
        let result = try JSONDecoder().decode(GenericObject.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(result, GenericObject.genericObject([
            .init(
                key: "ints",
                value: .array([.int(1), .int(2), .int(3), .int(5), .int(8), .int(13), .int(21), .int(34), .int(55)]
            ))
        ]))
    }

    func testGenericObjectDecodeArrayOfStrings() throws {
        let json = "{\"ints\":[\"1\", \"2\", \"3\", \"5\", \"8\", \"13\", \"21\", \"34\", \"55\"]}"
        let result = try JSONDecoder().decode(GenericObject.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(result, GenericObject.genericObject([
            .init(
                key: "ints",
                value: .array([
                    .string("1"),
                    .string("2"),
                    .string("3"),
                    .string("5"),
                    .string("8"),
                    .string("13"),
                    .string("21"),
                    .string("34"),
                    .string("55")
                ]
            ))
        ]))
    }

    func testGenericObjectDecodeNestedOfInts() throws {
        let json = "{\"parent\":{\"ints\":[1, 2, 3, 5, 8, 13, 21, 34, 55]}}"
        let result = try JSONDecoder().decode(GenericObject.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(result, GenericObject.genericObject([
            .init(
                key: "parent",
                value: .genericObject([.init(
                    key: "ints",
                    value: .array([.int(1), .int(2), .int(3), .int(5), .int(8), .int(13), .int(21), .int(34), .int(55)])
                )])
            )
        ]))
    }

    func testGenericObjectDecodeArrayOfObjects() throws {
        let json = "{\"objects\":[{\"someKey\": \"1\"},{\"someKey\": \"2\"}]}"
        let result = try JSONDecoder().decode(GenericObject.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(result, GenericObject.genericObject([
            .init(
                key: "objects",
                value: .array([
                    .genericObject([.init(key: "someKey", value: .string("1"))]),
                    .genericObject([.init(key: "someKey", value: .string("2"))])
                ]
            ))
        ]))
    }

    static var allTests = [
        ("testGenericObjectDecodeString", testGenericObjectDecodeString),
        ("testGenericObjectDecodeInt", testGenericObjectDecodeInt),
        ("testGenericObjectDecodeBoolTrue", testGenericObjectDecodeBoolTrue),
        ("testGenericObjectDecodeBoolFalse", testGenericObjectDecodeBoolFalse),
        ("testGenericObjectDecodeNull", testGenericObjectDecodeNull),
        ("testGenericObjectDecodeDouble", testGenericObjectDecodeDouble),
        ("testGenericObjectDecodeArrayOfInts", testGenericObjectDecodeArrayOfInts),
        ("testGenericObjectDecodeArrayOfStrings", testGenericObjectDecodeArrayOfStrings),
        ("testGenericObjectDecodeNestedOfInts", testGenericObjectDecodeNestedOfInts),
        ("testGenericObjectDecodeArrayOfObjects", testGenericObjectDecodeArrayOfObjects)
    ]
}
