// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import MonitoredAppMiddleware
import MultipeerConnectivity
import MultipeerMiddleware
import SwiftRex
import SwiftRexMonitorEngine
extension AppAction {
    internal var monitorEngine: MonitorEngineAction? {
        get {
            guard case let .monitorEngine(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .monitorEngine = self, let newValue = newValue else { return }
            self = .monitorEngine(newValue)
        }
    }

    internal var isMonitorEngine: Bool {
        self.monitorEngine != nil
    }

}
