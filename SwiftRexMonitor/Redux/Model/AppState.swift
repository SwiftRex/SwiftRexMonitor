import Foundation
import MultipeerRedux

public struct AppState: Encodable, Equatable {
    public var multipeer: MultipeerState
    public var monitoredPeers: [MonitoredPeer]

    public static var empty: AppState {
        return .init(multipeer: .empty, monitoredPeers: [])
    }
}
