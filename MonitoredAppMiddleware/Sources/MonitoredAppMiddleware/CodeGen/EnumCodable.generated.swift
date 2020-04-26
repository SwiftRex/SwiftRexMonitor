// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import MultipeerConnectivity
import MultipeerMiddleware
extension MessageType: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum IntroductionKeys: String, CodingKey {
            case associatedValue0
        }
        enum ActionKeys: String, CodingKey {
            case associatedValue0
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch try container.decode(String.self, forKey: .type) {
        case "introduction":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.IntroductionKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(PeerMetadata.self, forKey: .associatedValue0)
            self = .introduction(associatedValues0)
        case "action":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.ActionKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(ActionMessage.self, forKey: .associatedValue0)
            self = .action(associatedValues0)
        default:
            throw DecodingError.keyNotFound(CodingKeys.type, .init(codingPath: container.codingPath, debugDescription: "Unknown key"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .introduction(associatedValue0):
            try container.encode("introduction", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.IntroductionKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        case let .action(associatedValue0):
            try container.encode("action", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.ActionKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        }
    }
}
