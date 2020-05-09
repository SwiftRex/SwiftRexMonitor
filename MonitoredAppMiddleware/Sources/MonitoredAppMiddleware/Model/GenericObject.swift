import Foundation

public struct KeyedGenericObject: Codable, Comparable, Equatable {
    public let key: String
    public let value: GenericObject

    public static func < (lhs: KeyedGenericObject, rhs: KeyedGenericObject) -> Bool {
        lhs.key < rhs.key
    }
}

public indirect enum GenericObject: Equatable {
    case array([GenericObject])
    case genericObject([KeyedGenericObject])
    case bool(Bool)
    case double(Double)
    case uuid(UUID)
    case int(Int)
    case string(String)
    case null
}

extension GenericObject: Codable {
    struct CodingKeys: CodingKey {
        let intValue: Int?
        let stringValue: String

        init?(intValue: Int) {
            return nil
        }

        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }
    }

    public init(from decoder: Decoder) throws { // swiftlint:disable:this cyclomatic_complexity
        if let keyed = try? decoder.container(keyedBy: CodingKeys.self) {
            var array = [KeyedGenericObject]()
            for key in keyed.allKeys {
                if let genericObject = try? keyed.decode(GenericObject.self, forKey: key) {
                    array.append(.init(key: key.stringValue, value: genericObject))
                } else {
                    throw DecodingError.dataCorruptedError(forKey: key, in: keyed, debugDescription: "Unknown type")
                }
            }
            self = .genericObject(array.sorted())
        } else if var unkeyed = try? decoder.unkeyedContainer() {
            var array = [GenericObject]()
            while !unkeyed.isAtEnd {
                if let genericObject = try? unkeyed.decode(GenericObject.self) {
                    array.append(genericObject)
                } else {
                    throw DecodingError.dataCorruptedError(in: unkeyed, debugDescription: "Unknown type")
                }
            }
            self = .array(array)
        } else if let singleValue = try? decoder.singleValueContainer() {
            if let int = try? singleValue.decode(Int.self) {
                self = .int(int)
            } else if let bool = try? singleValue.decode(Bool.self) {
                self = .bool(bool)
            } else if let double = try? singleValue.decode(Double.self) {
                self = .double(double)
            } else if let uuid = try? singleValue.decode(UUID.self) {
                self = .uuid(uuid)
            } else if let string = try? singleValue.decode(String.self) {
                self = .string(string)
            } else if singleValue.decodeNil() {
                self = .null
            } else {
                throw DecodingError.dataCorruptedError(in: singleValue, debugDescription: "Unknown type")
            }
        } else {
            self = .null
        }
    }

    public func encode(to encoder: Encoder) throws {
        throw EncodingError.invalidValue("Not implemented yet", EncodingError.Context(codingPath: encoder.codingPath,
                                                                                      debugDescription: "Not implemented yet"))
    }
}
