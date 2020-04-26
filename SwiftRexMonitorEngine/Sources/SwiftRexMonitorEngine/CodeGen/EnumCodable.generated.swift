// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import Foundation
import MonitoredAppMiddleware
import MultipeerMiddleware
import SwiftRex
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
            case action
            case remoteDate
            case state
            case actionSource
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
            let associatedValues0 = try subContainer.decode(String.self, forKey: .action)
            let associatedValues1 = try subContainer.decode(Date.self, forKey: .remoteDate)
            let associatedValues2 = try subContainer.decode(GenericObject?.self, forKey: .state)
            let associatedValues3 = try subContainer.decode(ActionSource.self, forKey: .actionSource)
            let associatedValues4 = try subContainer.decode(Peer.self, forKey: .peer)
            self = .gotAction(action: associatedValues0, remoteDate: associatedValues1, state: associatedValues2, actionSource: associatedValues3, peer: associatedValues4)
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
        case let .gotAction(action, remoteDate, state, actionSource, peer):
            try container.encode("gotAction", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.GotActionKeys.self, forKey: .associatedValues)
            try subContainer.encode(action, forKey: .action)
            try subContainer.encode(remoteDate, forKey: .remoteDate)
            try subContainer.encode(state, forKey: .state)
            try subContainer.encode(actionSource, forKey: .actionSource)
            try subContainer.encode(peer, forKey: .peer)
        case let .gotGreetings(associatedValue0, peer):
            try container.encode("gotGreetings", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.GotGreetingsKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
            try subContainer.encode(peer, forKey: .peer)
        }
    }
}
extension MonitorEngineAction: Encodable {
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
