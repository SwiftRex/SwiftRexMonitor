// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import MultipeerConnectivity
import MultipeerRedux
extension AppAction: Encodable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum MonitorKeys: String, CodingKey {
            case associatedValue0
        }
        enum MultipeerKeys: String, CodingKey {
            case associatedValue0
        }
    }


    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .start:
            try container.encode("start", forKey: .type)
        case let .monitor(associatedValue0):
            try container.encode("monitor", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.MonitorKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        case let .multipeer(associatedValue0):
            try container.encode("multipeer", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.MultipeerKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        }
    }
}
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
extension MonitorAction: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum PeerListHasChangedKeys: String, CodingKey {
            case associatedValue0
        }
        enum EvaluateDataKeys: String, CodingKey {
            case associatedValue0
            case from
        }
        enum GotActionKeys: String, CodingKey {
            case associatedValue0
            case peer
        }
        enum GotGreetingsKeys: String, CodingKey {
            case associatedValue0
            case peer
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch try container.decode(String.self, forKey: .type) {
        case "start":
            self = .start
        case "peerListNeedsRefresh":
            self = .peerListNeedsRefresh
        case "peerListHasChanged":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.PeerListHasChangedKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode([Peer].self, forKey: .associatedValue0)
            self = .peerListHasChanged(associatedValues0)
        case "evaluateData":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.EvaluateDataKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(Data.self, forKey: .associatedValue0)
            let associatedValues1 = try subContainer.decode(Peer.self, forKey: .from)
            self = .evaluateData(associatedValues0, from: associatedValues1)
        case "gotAction":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.GotActionKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(ActionMessage.self, forKey: .associatedValue0)
            let associatedValues1 = try subContainer.decode(Peer.self, forKey: .peer)
            self = .gotAction(associatedValues0, peer: associatedValues1)
        case "gotGreetings":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.GotGreetingsKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(PeerMetadata.self, forKey: .associatedValue0)
            let associatedValues1 = try subContainer.decode(Peer.self, forKey: .peer)
            self = .gotGreetings(associatedValues0, peer: associatedValues1)
        default:
            throw DecodingError.keyNotFound(CodingKeys.type, .init(codingPath: container.codingPath, debugDescription: "Unknown key"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .start:
            try container.encode("start", forKey: .type)
        case .peerListNeedsRefresh:
            try container.encode("peerListNeedsRefresh", forKey: .type)
        case let .peerListHasChanged(associatedValue0):
            try container.encode("peerListHasChanged", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.PeerListHasChangedKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        case let .evaluateData(associatedValue0, from):
            try container.encode("evaluateData", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.EvaluateDataKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
            try subContainer.encode(from, forKey: .from)
        case let .gotAction(associatedValue0, peer):
            try container.encode("gotAction", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.GotActionKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
            try subContainer.encode(peer, forKey: .peer)
        case let .gotGreetings(associatedValue0, peer):
            try container.encode("gotGreetings", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.GotGreetingsKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
            try subContainer.encode(peer, forKey: .peer)
        }
    }
}
extension PayloadTree: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum UnkeyedKeys: String, CodingKey {
            case associatedValue0
        }
        enum KeyedKeys: String, CodingKey {
            case key
            case value
        }
        enum ArrayKeys: String, CodingKey {
            case key
            case values
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch try container.decode(String.self, forKey: .type) {
        case "unkeyed":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.UnkeyedKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(String.self, forKey: .associatedValue0)
            self = .unkeyed(associatedValues0)
        case "keyed":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.KeyedKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(String.self, forKey: .key)
            let associatedValues1 = try subContainer.decode(String.self, forKey: .value)
            self = .keyed(key: associatedValues0, value: associatedValues1)
        case "array":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.ArrayKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(String.self, forKey: .key)
            let associatedValues1 = try subContainer.decode([PayloadTree].self, forKey: .values)
            self = .array(key: associatedValues0, values: associatedValues1)
        default:
            throw DecodingError.keyNotFound(CodingKeys.type, .init(codingPath: container.codingPath, debugDescription: "Unknown key"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .unkeyed(associatedValue0):
            try container.encode("unkeyed", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.UnkeyedKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        case let .keyed(key, value):
            try container.encode("keyed", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.KeyedKeys.self, forKey: .associatedValues)
            try subContainer.encode(key, forKey: .key)
            try subContainer.encode(value, forKey: .value)
        case let .array(key, values):
            try container.encode("array", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.ArrayKeys.self, forKey: .associatedValues)
            try subContainer.encode(key, forKey: .key)
            try subContainer.encode(values, forKey: .values)
        }
    }
}
