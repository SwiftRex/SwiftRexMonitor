import Foundation
import MultipeerMiddleware

public struct MonitorEngineState: Encodable, Equatable {
    public var multipeer: MultipeerState
    public var monitoredPeers: [MonitoredPeer]

    public static var empty: MonitorEngineState {
        return .init(multipeer: .empty, monitoredPeers: [])
    }
}
