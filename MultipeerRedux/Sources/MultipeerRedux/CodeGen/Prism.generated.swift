// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import MultipeerConnectivity
extension MultipeerAction {
    public var advertiser: MultipeerAdvertiserAction? {
        get {
            guard case let .advertiser(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .advertiser = self, let newValue = newValue else { return }
            self = .advertiser(newValue)
        }
    }

    public var isAdvertiser: Bool {
        self.advertiser != nil
    }

    public var browser: MultipeerBrowserAction? {
        get {
            guard case let .browser(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .browser = self, let newValue = newValue else { return }
            self = .browser(newValue)
        }
    }

    public var isBrowser: Bool {
        self.browser != nil
    }

    public var connectivity: MultipeerSessionConnectivityAction? {
        get {
            guard case let .connectivity(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .connectivity = self, let newValue = newValue else { return }
            self = .connectivity(newValue)
        }
    }

    public var isConnectivity: Bool {
        self.connectivity != nil
    }

    public var messaging: MultipeerSessionMessagingAction? {
        get {
            guard case let .messaging(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .messaging = self, let newValue = newValue else { return }
            self = .messaging(newValue)
        }
    }

    public var isMessaging: Bool {
        self.messaging != nil
    }

}
extension MultipeerAdvertiserAction {
    public var startAdvertising: Void? {
        get {
            guard case .startAdvertising = self else { return nil }
            return ()
        }
    }

    public var isStartAdvertising: Bool {
        self.startAdvertising != nil
    }

    public var startedAdvertising: Void? {
        get {
            guard case .startedAdvertising = self else { return nil }
            return ()
        }
    }

    public var isStartedAdvertising: Bool {
        self.startedAdvertising != nil
    }

    public var stopAdvertising: Void? {
        get {
            guard case .stopAdvertising = self else { return nil }
            return ()
        }
    }

    public var isStopAdvertising: Bool {
        self.stopAdvertising != nil
    }

    public var stoppedAdvertising: Void? {
        get {
            guard case .stoppedAdvertising = self else { return nil }
            return ()
        }
    }

    public var isStoppedAdvertising: Bool {
        self.stoppedAdvertising != nil
    }

    public var stoppedAdvertisingDueToError: Error? {
        get {
            guard case let .stoppedAdvertisingDueToError(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .stoppedAdvertisingDueToError = self, let newValue = newValue else { return }
            self = .stoppedAdvertisingDueToError(newValue)
        }
    }

    public var isStoppedAdvertisingDueToError: Bool {
        self.stoppedAdvertisingDueToError != nil
    }

    public var invited: (by: Peer, context: Data?)? {
        get {
            guard case let .invited(by, context) = self else { return nil }
            return (by, context)
        }
        set {
            guard case .invited = self, let newValue = newValue else { return }
            self = .invited(by: newValue.0, context: newValue.1)
        }
    }

    public var isInvited: Bool {
        self.invited != nil
    }

    public var acceptedInvitation: (from: Peer, context: Data?)? {
        get {
            guard case let .acceptedInvitation(from, context) = self else { return nil }
            return (from, context)
        }
        set {
            guard case .acceptedInvitation = self, let newValue = newValue else { return }
            self = .acceptedInvitation(from: newValue.0, context: newValue.1)
        }
    }

    public var isAcceptedInvitation: Bool {
        self.acceptedInvitation != nil
    }

    public var declinedInvitation: (from: Peer, context: Data?)? {
        get {
            guard case let .declinedInvitation(from, context) = self else { return nil }
            return (from, context)
        }
        set {
            guard case .declinedInvitation = self, let newValue = newValue else { return }
            self = .declinedInvitation(from: newValue.0, context: newValue.1)
        }
    }

    public var isDeclinedInvitation: Bool {
        self.declinedInvitation != nil
    }

}
extension MultipeerAdvertiserState {
    public var advertising: Void? {
        get {
            guard case .advertising = self else { return nil }
            return ()
        }
    }

    public var isAdvertising: Bool {
        self.advertising != nil
    }

    public var stopped: Void? {
        get {
            guard case .stopped = self else { return nil }
            return ()
        }
    }

    public var isStopped: Bool {
        self.stopped != nil
    }

    public var error: MultipeerAdvertiserError? {
        get {
            guard case let .error(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .error = self, let newValue = newValue else { return }
            self = .error(newValue)
        }
    }

    public var isError: Bool {
        self.error != nil
    }

}
extension MultipeerBrowserAction {
    public var startBrowsing: Void? {
        get {
            guard case .startBrowsing = self else { return nil }
            return ()
        }
    }

    public var isStartBrowsing: Bool {
        self.startBrowsing != nil
    }

    public var stopBrowsing: Void? {
        get {
            guard case .stopBrowsing = self else { return nil }
            return ()
        }
    }

    public var isStopBrowsing: Bool {
        self.stopBrowsing != nil
    }

    public var startedBrowsing: Void? {
        get {
            guard case .startedBrowsing = self else { return nil }
            return ()
        }
    }

    public var isStartedBrowsing: Bool {
        self.startedBrowsing != nil
    }

    public var stoppedBrowsing: Void? {
        get {
            guard case .stoppedBrowsing = self else { return nil }
            return ()
        }
    }

    public var isStoppedBrowsing: Bool {
        self.stoppedBrowsing != nil
    }

    public var stoppedBrowsingDueToError: Error? {
        get {
            guard case let .stoppedBrowsingDueToError(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .stoppedBrowsingDueToError = self, let newValue = newValue else { return }
            self = .stoppedBrowsingDueToError(newValue)
        }
    }

    public var isStoppedBrowsingDueToError: Bool {
        self.stoppedBrowsingDueToError != nil
    }

    public var foundPeer: (Peer, info: [String: String]?, browser: MCNearbyServiceBrowser)? {
        get {
            guard case let .foundPeer(associatedValue0, info, browser) = self else { return nil }
            return (associatedValue0, info, browser)
        }
        set {
            guard case .foundPeer = self, let newValue = newValue else { return }
            self = .foundPeer(newValue.0, info: newValue.1, browser: newValue.2)
        }
    }

    public var isFoundPeer: Bool {
        self.foundPeer != nil
    }

    public var lostPeer: Peer? {
        get {
            guard case let .lostPeer(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .lostPeer = self, let newValue = newValue else { return }
            self = .lostPeer(newValue)
        }
    }

    public var isLostPeer: Bool {
        self.lostPeer != nil
    }

    public var manuallyInvite: (Peer, browser: MCNearbyServiceBrowser)? {
        get {
            guard case let .manuallyInvite(associatedValue0, browser) = self else { return nil }
            return (associatedValue0, browser)
        }
        set {
            guard case .manuallyInvite = self, let newValue = newValue else { return }
            self = .manuallyInvite(newValue.0, browser: newValue.1)
        }
    }

    public var isManuallyInvite: Bool {
        self.manuallyInvite != nil
    }

    public var didSendInvitation: Peer? {
        get {
            guard case let .didSendInvitation(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .didSendInvitation = self, let newValue = newValue else { return }
            self = .didSendInvitation(newValue)
        }
    }

    public var isDidSendInvitation: Bool {
        self.didSendInvitation != nil
    }

    public var remoteAcceptedInvitation: Peer? {
        get {
            guard case let .remoteAcceptedInvitation(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .remoteAcceptedInvitation = self, let newValue = newValue else { return }
            self = .remoteAcceptedInvitation(newValue)
        }
    }

    public var isRemoteAcceptedInvitation: Bool {
        self.remoteAcceptedInvitation != nil
    }

    public var remoteDeclinedInvitation: (Peer, error: Error)? {
        get {
            guard case let .remoteDeclinedInvitation(associatedValue0, error) = self else { return nil }
            return (associatedValue0, error)
        }
        set {
            guard case .remoteDeclinedInvitation = self, let newValue = newValue else { return }
            self = .remoteDeclinedInvitation(newValue.0, error: newValue.1)
        }
    }

    public var isRemoteDeclinedInvitation: Bool {
        self.remoteDeclinedInvitation != nil
    }

}
extension MultipeerSessionConnectivityAction {
    public var startMonitoring: Void? {
        get {
            guard case .startMonitoring = self else { return nil }
            return ()
        }
    }

    public var isStartMonitoring: Bool {
        self.startMonitoring != nil
    }

    public var stoppedMonitoring: Void? {
        get {
            guard case .stoppedMonitoring = self else { return nil }
            return ()
        }
    }

    public var isStoppedMonitoring: Bool {
        self.stoppedMonitoring != nil
    }

    public var peerConnected: Peer? {
        get {
            guard case let .peerConnected(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .peerConnected = self, let newValue = newValue else { return }
            self = .peerConnected(newValue)
        }
    }

    public var isPeerConnected: Bool {
        self.peerConnected != nil
    }

    public var peerDisconnected: Peer? {
        get {
            guard case let .peerDisconnected(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .peerDisconnected = self, let newValue = newValue else { return }
            self = .peerDisconnected(newValue)
        }
    }

    public var isPeerDisconnected: Bool {
        self.peerDisconnected != nil
    }

    public var peerIsConnecting: Peer? {
        get {
            guard case let .peerIsConnecting(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .peerIsConnecting = self, let newValue = newValue else { return }
            self = .peerIsConnecting(newValue)
        }
    }

    public var isPeerIsConnecting: Bool {
        self.peerIsConnecting != nil
    }

}
extension MultipeerSessionMessagingAction {
    public var startMonitoring: Void? {
        get {
            guard case .startMonitoring = self else { return nil }
            return ()
        }
    }

    public var isStartMonitoring: Bool {
        self.startMonitoring != nil
    }

    public var stoppedMonitoring: Void? {
        get {
            guard case .stoppedMonitoring = self else { return nil }
            return ()
        }
    }

    public var isStoppedMonitoring: Bool {
        self.stoppedMonitoring != nil
    }

    public var gotData: (Data, from: Peer)? {
        get {
            guard case let .gotData(associatedValue0, from) = self else { return nil }
            return (associatedValue0, from)
        }
        set {
            guard case .gotData = self, let newValue = newValue else { return }
            self = .gotData(newValue.0, from: newValue.1)
        }
    }

    public var isGotData: Bool {
        self.gotData != nil
    }

    public var sendData: Data? {
        get {
            guard case let .sendData(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .sendData = self, let newValue = newValue else { return }
            self = .sendData(newValue)
        }
    }

    public var isSendData: Bool {
        self.sendData != nil
    }

    public var sendDataToPeer: (Data, to: Peer)? {
        get {
            guard case let .sendDataToPeer(associatedValue0, to) = self else { return nil }
            return (associatedValue0, to)
        }
        set {
            guard case .sendDataToPeer = self, let newValue = newValue else { return }
            self = .sendDataToPeer(newValue.0, to: newValue.1)
        }
    }

    public var isSendDataToPeer: Bool {
        self.sendDataToPeer != nil
    }

    public var sendDataResult: (Data, to: Peer?, result: Result<Void, Error>)? {
        get {
            guard case let .sendDataResult(associatedValue0, to, result) = self else { return nil }
            return (associatedValue0, to, result)
        }
        set {
            guard case .sendDataResult = self, let newValue = newValue else { return }
            self = .sendDataResult(newValue.0, to: newValue.1, result: newValue.2)
        }
    }

    public var isSendDataResult: Bool {
        self.sendDataResult != nil
    }

}
