import Foundation

/// Wraps a value but causes it to be treated as "value-less" for the purposes
/// of automatic Equatable, Hashable, and Codable synthesis. This allows one to
/// declare a "cache"-like property in a value type without giving up the rest
/// of the benefits of synthesis.
@dynamicMemberLookup
@propertyWrapper
public struct Transient<Wrapped>: Equatable, Hashable, Encodable {
    public var wrappedValue: Wrapped

    public static func == (lhs: Transient<Wrapped>, rhs: Transient<Wrapped>) -> Bool {
        // By always returning true, transient values never produce false negatives
        // that cause two otherwise equal values to become unequal. In other words,
        // they are ignored for the purposes of equality.
        return true
    }

    public func hash(into hasher: inout Hasher) {
        // Transient values do not contribute to the hash value.
    }

    public init(_ wrappedValue: Wrapped) {
        self.wrappedValue = wrappedValue
    }

    public func encode(to encoder: Encoder) throws {
        // Transient properties do not get encoded.
    }

    public subscript<T>(dynamicMember keyPath: KeyPath<Wrapped, T>) -> T {
        wrappedValue[keyPath: keyPath]
    }
}

extension Transient where Wrapped: Encodable {
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

extension Transient: Decodable where Wrapped: Decodable {
    public init(from decoder: Decoder) throws {
        self = .init(try .init(from: decoder))
    }
}

extension Transient where Wrapped: Equatable {
    public static func == (lhs: Transient<Wrapped>, rhs: Transient<Wrapped>) -> Bool {
        return lhs.wrappedValue == rhs.wrappedValue
    }
}

extension Transient where Wrapped: Hashable {
    public func hash(into hasher: inout Hasher) {
        wrappedValue.hash(into: &hasher)
    }
}
