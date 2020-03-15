import Foundation

public struct MultipeerAdvertiserError: Codable, Error {
    public let innerError: Error
    public init(innerError: Error) {
        self.innerError = innerError
    }

    public var localizedDescription: String {
        innerError.localizedDescription
    }

    enum CodingKeys: String, CodingKey {
        case localizedDescription
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(localizedDescription, forKey: .localizedDescription)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let localizedDescription = try container.decode(String.self, forKey: .localizedDescription)
        innerError = NSError(domain: localizedDescription, code: -1, userInfo: nil)
    }

}

// sourcery: EnumCodable=EncodeOnly
// sourcery: Prism
public enum MultipeerAdvertiserState: Equatable {
    case advertising
    case stopped
    case error(MultipeerAdvertiserError)
}

public func == (lhs: MultipeerAdvertiserState, rhs: MultipeerAdvertiserState) -> Bool {
    switch (lhs, rhs) {
    case (.advertising, .advertising):
        return true
    case (.stopped, .stopped):
        return true
    case let (.error(lError), .error(rError)):
        return lError.localizedDescription == rError.localizedDescription
    default: return false
    }
}
