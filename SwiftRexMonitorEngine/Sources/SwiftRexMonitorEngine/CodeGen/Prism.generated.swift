// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import Foundation
import MonitoredAppMiddleware
import MultipeerMiddleware
import SwiftRex
extension MonitorAction {
    public var start: Void? {
        get {
            guard case .start = self else { return nil }
            return ()
        }
    }

    public var isStart: Bool {
        self.start != nil
    }

    public var peerListNeedsRefresh: Void? {
        get {
            guard case .peerListNeedsRefresh = self else { return nil }
            return ()
        }
    }

    public var isPeerListNeedsRefresh: Bool {
        self.peerListNeedsRefresh != nil
    }

    public var peerListHasChanged: [Peer]? {
        get {
            guard case let .peerListHasChanged(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .peerListHasChanged = self, let newValue = newValue else { return }
            self = .peerListHasChanged(newValue)
        }
    }

    public var isPeerListHasChanged: Bool {
        self.peerListHasChanged != nil
    }

    public var evaluateData: (Data, from: Peer)? {
        get {
            guard case let .evaluateData(associatedValue0, from) = self else { return nil }
            return (associatedValue0, from)
        }
        set {
            guard case .evaluateData = self, let newValue = newValue else { return }
            self = .evaluateData(newValue.0, from: newValue.1)
        }
    }

    public var isEvaluateData: Bool {
        self.evaluateData != nil
    }

    public var gotAction: (action: String, remoteDate: Date, state: GenericObject?, actionSource: ActionSource, peer: Peer)? {
        get {
            guard case let .gotAction(action, remoteDate, state, actionSource, peer) = self else { return nil }
            return (action, remoteDate, state, actionSource, peer)
        }
        set {
            guard case .gotAction = self, let newValue = newValue else { return }
            self = .gotAction(action: newValue.0, remoteDate: newValue.1, state: newValue.2, actionSource: newValue.3, peer: newValue.4)
        }
    }

    public var isGotAction: Bool {
        self.gotAction != nil
    }

    public var gotGreetings: (PeerMetadata, peer: Peer)? {
        get {
            guard case let .gotGreetings(associatedValue0, peer) = self else { return nil }
            return (associatedValue0, peer)
        }
        set {
            guard case .gotGreetings = self, let newValue = newValue else { return }
            self = .gotGreetings(newValue.0, peer: newValue.1)
        }
    }

    public var isGotGreetings: Bool {
        self.gotGreetings != nil
    }

}
extension MonitorEngineAction {
    public var start: Void? {
        get {
            guard case .start = self else { return nil }
            return ()
        }
    }

    public var isStart: Bool {
        self.start != nil
    }

    public var monitor: MonitorAction? {
        get {
            guard case let .monitor(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .monitor = self, let newValue = newValue else { return }
            self = .monitor(newValue)
        }
    }

    public var isMonitor: Bool {
        self.monitor != nil
    }

    public var multipeer: MultipeerAction? {
        get {
            guard case let .multipeer(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .multipeer = self, let newValue = newValue else { return }
            self = .multipeer(newValue)
        }
    }

    public var isMultipeer: Bool {
        self.multipeer != nil
    }

}
