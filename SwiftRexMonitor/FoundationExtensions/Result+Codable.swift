import Foundation

extension Result {
    enum CodingKeys: String, CodingKey {
        case success
        case failure
    }
}

extension Result: Encodable where Success: Encodable, Failure: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .success(value):
            try container.encode(value, forKey: .success)
        case let .failure(error):
            try container.encode(error, forKey: .failure)
        }
    }
}

extension Result: Decodable where Success: Decodable, Failure: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if container.allKeys.contains(.success) {
            self = .success(try container.decode(Success.self, forKey: .success))
        } else {
            self = .failure(try container.decode(Failure.self, forKey: .failure))
        }
    }
}
