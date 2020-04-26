import Foundation
import SwiftRex

final class MultipeerBridgeMonitorMiddleware: Middleware {
    typealias InputActionType = MonitorEngineAction
    typealias OutputActionType = MonitorEngineAction
    typealias StateType = Void

    private var output: AnyActionHandler<OutputActionType>?
    private var getState: GetState<StateType>?

    init() {
    }

    func receiveContext(getState: @escaping GetState<StateType>, output: AnyActionHandler<OutputActionType>) {
        self.getState = getState
        self.output = output
    }

    func handle(action: InputActionType, from dispatcher: ActionSource, afterReducer: inout AfterReducer) {
        switch action {
        case .start:
            start()
        case .multipeer(.connectivity(.peerConnected)), .multipeer(.connectivity(.peerDisconnected)):
            output?.dispatch(.monitor(.peerListNeedsRefresh))
        case let .multipeer(.messaging(.gotData(data, peer))):
            output?.dispatch(.monitor(.evaluateData(data, from: peer)))
        default:
            break
        }
    }

    private func start() {
        output?.dispatch(.monitor(.start))
        output?.dispatch(.multipeer(.connectivity(.startMonitoring)))
        output?.dispatch(.multipeer(.messaging(.startMonitoring)))
        output?.dispatch(.multipeer(.browser(.startBrowsing)))
    }
}
