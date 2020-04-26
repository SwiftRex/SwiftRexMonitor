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
    }


    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .monitorEngine(associatedValue0):
            try container.encode("monitorEngine", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.MonitorEngineKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        }
    }
}
