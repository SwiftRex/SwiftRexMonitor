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

    internal var pasteboard: PasteboardAction? {
        get {
            guard case let .pasteboard(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .pasteboard = self, let newValue = newValue else { return }
            self = .pasteboard(newValue)
        }
    }

    internal var isPasteboard: Bool {
        self.pasteboard != nil
    }

    internal var router: RouterAction? {
        get {
            guard case let .router(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .router = self, let newValue = newValue else { return }
            self = .router(newValue)
        }
    }

    internal var isRouter: Bool {
        self.router != nil
    }

}
extension NavigationTree {
    internal var home: Int?? {
        get {
            guard case let .home(selectedPeer) = self else { return nil }
            return (selectedPeer)
        }
        set {
            guard case .home = self, let newValue = newValue else { return }
            self = .home(selectedPeer: newValue)
        }
    }

    internal var isHome: Bool {
        self.home != nil
    }

}
extension PasteboardAction {
    internal var copy: String? {
        get {
            guard case let .copy(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .copy = self, let newValue = newValue else { return }
            self = .copy(newValue)
        }
    }

    internal var isCopy: Bool {
        self.copy != nil
    }

}
extension RouterAction {
    internal var changeAppSelection: Int?? {
        get {
            guard case let .changeAppSelection(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .changeAppSelection = self, let newValue = newValue else { return }
            self = .changeAppSelection(newValue)
        }
    }

    internal var isChangeAppSelection: Bool {
        self.changeAppSelection != nil
    }

}
