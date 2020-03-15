import Foundation

public struct ClientInstallationId: Codable, Hashable, RawRepresentable {
    public let value: String

    public init?(rawValue: String) {
        guard !rawValue.isEmpty else { return nil }
        self.value = rawValue
    }

    public var rawValue: String {
        return value
    }
}
