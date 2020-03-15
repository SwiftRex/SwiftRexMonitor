// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import MultipeerConnectivity
import MultipeerRedux
extension AppAction: Encodable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum MonitorKeys: String, CodingKey {
            case associatedValues0
        }
        enum MultipeerKeys: String, CodingKey {
            case associatedValues0
        }
    }


    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .start:
            try container.encode("start", forKey: .type)
        case let .monitor(associatedValues):
            try container.encode("monitor", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.MonitorKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues, forKey: .associatedValues0)
        case let .multipeer(associatedValues):
            try container.encode("multipeer", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.MultipeerKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues, forKey: .associatedValues0)
        }
    }
}
extension MessageType: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum IntroductionKeys: String, CodingKey {
            case associatedValues0
        }
        enum ActionKeys: String, CodingKey {
            case associatedValues0
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch try container.decode(String.self, forKey: .type) {
        case "introduction":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.IntroductionKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(PeerMetadata.self, forKey: .associatedValues0)
            self = .introduction(associatedValues0)
        case "action":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.ActionKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(ActionMessage.self, forKey: .associatedValues0)
            self = .action(associatedValues0)
        default:
            throw DecodingError.keyNotFound(CodingKeys.type, .init(codingPath: container.codingPath, debugDescription: "Unknown key"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .introduction(associatedValues):
            try container.encode("introduction", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.IntroductionKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues, forKey: .associatedValues0)
        case let .action(associatedValues):
            try container.encode("action", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.ActionKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues, forKey: .associatedValues0)
        }
    }
}
extension MonitorAction: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum PeerListHasChangedKeys: String, CodingKey {
            case associatedValues0
        }
        enum EvaluateDataKeys: String, CodingKey {
            case associatedValues0
            case associatedValues1 = "from"
        }
        enum GotActionKeys: String, CodingKey {
            case associatedValues0
            case associatedValues1 = "peer"
        }
        enum GotGreetingsKeys: String, CodingKey {
            case associatedValues0
            case associatedValues1 = "peer"
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
            let associatedValues0 = try subContainer.decode([Peer].self, forKey: .associatedValues0)
            self = .peerListHasChanged(associatedValues0)
        case "evaluateData":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.EvaluateDataKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(Data.self, forKey: .associatedValues0)
            let associatedValues1 = try subContainer.decode(Peer.self, forKey: .associatedValues1)
            self = .evaluateData(associatedValues0, from: associatedValues1)
        case "gotAction":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.GotActionKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(ActionMessage.self, forKey: .associatedValues0)
            let associatedValues1 = try subContainer.decode(Peer.self, forKey: .associatedValues1)
            self = .gotAction(associatedValues0, peer: associatedValues1)
        case "gotGreetings":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.GotGreetingsKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(PeerMetadata.self, forKey: .associatedValues0)
            let associatedValues1 = try subContainer.decode(Peer.self, forKey: .associatedValues1)
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
        case let .peerListHasChanged(associatedValues):
            try container.encode("peerListHasChanged", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.PeerListHasChangedKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues, forKey: .associatedValues0)
        case let .evaluateData(associatedValues):
            try container.encode("evaluateData", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.EvaluateDataKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues.0, forKey: .associatedValues0)
            try subContainer.encode(associatedValues.from, forKey: .associatedValues1)
        case let .gotAction(associatedValues):
            try container.encode("gotAction", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.GotActionKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues.0, forKey: .associatedValues0)
            try subContainer.encode(associatedValues.peer, forKey: .associatedValues1)
        case let .gotGreetings(associatedValues):
            try container.encode("gotGreetings", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.GotGreetingsKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues.0, forKey: .associatedValues0)
            try subContainer.encode(associatedValues.peer, forKey: .associatedValues1)
        }
    }
}
extension PayloadTree: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum UnkeyedKeys: String, CodingKey {
            case associatedValues0
        }
        enum KeyedKeys: String, CodingKey {
            case associatedValues0 = "key"
            case associatedValues1 = "value"
        }
        enum ArrayKeys: String, CodingKey {
            case associatedValues0 = "key"
            case associatedValues1 = "values"
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch try container.decode(String.self, forKey: .type) {
        case "unkeyed":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.UnkeyedKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(String.self, forKey: .associatedValues0)
            self = .unkeyed(associatedValues0)
        case "keyed":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.KeyedKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(String.self, forKey: .associatedValues0)
            let associatedValues1 = try subContainer.decode(String.self, forKey: .associatedValues1)
            self = .keyed(key: associatedValues0, value: associatedValues1)
        case "array":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.ArrayKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(String.self, forKey: .associatedValues0)
            let associatedValues1 = try subContainer.decode([PayloadTree].self, forKey: .associatedValues1)
            self = .array(key: associatedValues0, values: associatedValues1)
        default:
            throw DecodingError.keyNotFound(CodingKeys.type, .init(codingPath: container.codingPath, debugDescription: "Unknown key"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .unkeyed(associatedValues):
            try container.encode("unkeyed", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.UnkeyedKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues, forKey: .associatedValues0)
        case let .keyed(associatedValues):
            try container.encode("keyed", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.KeyedKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues.key, forKey: .associatedValues0)
            try subContainer.encode(associatedValues.value, forKey: .associatedValues1)
        case let .array(associatedValues):
            try container.encode("array", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.ArrayKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues.key, forKey: .associatedValues0)
            try subContainer.encode(associatedValues.values, forKey: .associatedValues1)
        }
    }
}
