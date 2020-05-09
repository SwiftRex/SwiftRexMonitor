// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import MonitoredAppMiddleware
import MultipeerConnectivity
import MultipeerMiddleware
import SwiftRex
import SwiftRexMonitorEngine
extension AppAction: Encodable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum MonitorEngineKeys: String, CodingKey {
            case associatedValue0
        }
        enum PasteboardKeys: String, CodingKey {
            case associatedValue0
        }
        enum RouterKeys: String, CodingKey {
            case associatedValue0
        }
    }


    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .monitorEngine(associatedValue0):
            try container.encode("monitorEngine", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.MonitorEngineKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        case let .pasteboard(associatedValue0):
            try container.encode("pasteboard", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.PasteboardKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        case let .router(associatedValue0):
            try container.encode("router", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.RouterKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        }
    }
}
extension NavigationTree: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum HomeKeys: String, CodingKey {
            case selectedPeer
        }
    }

    internal init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch try container.decode(String.self, forKey: .type) {
        case "home":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.HomeKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(Int?.self, forKey: .selectedPeer)
            self = .home(selectedPeer: associatedValues0)
        default:
            throw DecodingError.keyNotFound(CodingKeys.type, .init(codingPath: container.codingPath, debugDescription: "Unknown key"))
        }
    }

    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .home(selectedPeer):
            try container.encode("home", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.HomeKeys.self, forKey: .associatedValues)
            try subContainer.encode(selectedPeer, forKey: .selectedPeer)
        }
    }
}
extension PasteboardAction: Encodable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum CopyKeys: String, CodingKey {
            case associatedValue0
        }
    }


    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .copy(associatedValue0):
            try container.encode("copy", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.CopyKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        }
    }
}
extension RouterAction: Encodable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum ChangeAppSelectionKeys: String, CodingKey {
            case associatedValue0
        }
    }


    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .changeAppSelection(associatedValue0):
            try container.encode("changeAppSelection", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.ChangeAppSelectionKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        }
    }
}
