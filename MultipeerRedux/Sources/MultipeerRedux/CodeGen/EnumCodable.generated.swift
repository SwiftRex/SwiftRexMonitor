// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import MultipeerConnectivity
extension MultipeerAction: Encodable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum AdvertiserKeys: String, CodingKey {
            case associatedValue0
        }
        enum BrowserKeys: String, CodingKey {
            case associatedValue0
        }
        enum ConnectivityKeys: String, CodingKey {
            case associatedValue0
        }
        enum MessagingKeys: String, CodingKey {
            case associatedValue0
        }
    }


    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .advertiser(associatedValue0):
            try container.encode("advertiser", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.AdvertiserKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        case let .browser(associatedValue0):
            try container.encode("browser", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.BrowserKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        case let .connectivity(associatedValue0):
            try container.encode("connectivity", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.ConnectivityKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        case let .messaging(associatedValue0):
            try container.encode("messaging", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.MessagingKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        }
    }
}
extension MultipeerAdvertiserAction: Encodable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum StoppedAdvertisingDueToErrorKeys: String, CodingKey {
            case associatedValue0
        }
        enum InvitedKeys: String, CodingKey {
            case by
            case context
        }
        enum AcceptedInvitationKeys: String, CodingKey {
            case from
            case context
        }
        enum DeclinedInvitationKeys: String, CodingKey {
            case from
            case context
        }
    }


    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .startAdvertising:
            try container.encode("startAdvertising", forKey: .type)
        case .startedAdvertising:
            try container.encode("startedAdvertising", forKey: .type)
        case .stopAdvertising:
            try container.encode("stopAdvertising", forKey: .type)
        case .stoppedAdvertising:
            try container.encode("stoppedAdvertising", forKey: .type)
        case let .stoppedAdvertisingDueToError(associatedValue0):
            try container.encode("stoppedAdvertisingDueToError", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.StoppedAdvertisingDueToErrorKeys.self, forKey: .associatedValues)
            try subContainer.encode(encodeError(associatedValue0), forKey: .associatedValue0)
        case let .invited(by, context):
            try container.encode("invited", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.InvitedKeys.self, forKey: .associatedValues)
            try subContainer.encode(by, forKey: .by)
            try subContainer.encode(context, forKey: .context)
        case let .acceptedInvitation(from, context):
            try container.encode("acceptedInvitation", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.AcceptedInvitationKeys.self, forKey: .associatedValues)
            try subContainer.encode(from, forKey: .from)
            try subContainer.encode(context, forKey: .context)
        case let .declinedInvitation(from, context):
            try container.encode("declinedInvitation", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.DeclinedInvitationKeys.self, forKey: .associatedValues)
            try subContainer.encode(from, forKey: .from)
            try subContainer.encode(context, forKey: .context)
        }
    }
}
extension MultipeerAdvertiserState: Encodable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum ErrorKeys: String, CodingKey {
            case associatedValue0
        }
    }


    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .advertising:
            try container.encode("advertising", forKey: .type)
        case .stopped:
            try container.encode("stopped", forKey: .type)
        case let .error(associatedValue0):
            try container.encode("error", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.ErrorKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        }
    }
}
extension MultipeerBrowserAction: Encodable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum StoppedBrowsingDueToErrorKeys: String, CodingKey {
            case associatedValue0
        }
        enum FoundPeerKeys: String, CodingKey {
            case associatedValue0
            case info
            case browser
        }
        enum LostPeerKeys: String, CodingKey {
            case associatedValue0
        }
        enum ManuallyInviteKeys: String, CodingKey {
            case associatedValue0
            case browser
        }
        enum DidSendInvitationKeys: String, CodingKey {
            case associatedValue0
        }
        enum RemoteAcceptedInvitationKeys: String, CodingKey {
            case associatedValue0
        }
        enum RemoteDeclinedInvitationKeys: String, CodingKey {
            case associatedValue0
            case error
        }
    }


    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .startBrowsing:
            try container.encode("startBrowsing", forKey: .type)
        case .stopBrowsing:
            try container.encode("stopBrowsing", forKey: .type)
        case .startedBrowsing:
            try container.encode("startedBrowsing", forKey: .type)
        case .stoppedBrowsing:
            try container.encode("stoppedBrowsing", forKey: .type)
        case let .stoppedBrowsingDueToError(associatedValue0):
            try container.encode("stoppedBrowsingDueToError", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.StoppedBrowsingDueToErrorKeys.self, forKey: .associatedValues)
            try subContainer.encode(encodeError(associatedValue0), forKey: .associatedValue0)
        case let .foundPeer(associatedValue0, info, browser):
            try container.encode("foundPeer", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.FoundPeerKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
            try subContainer.encode(info, forKey: .info)
            try subContainer.encode(encodeBrowser(browser), forKey: .browser)
        case let .lostPeer(associatedValue0):
            try container.encode("lostPeer", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.LostPeerKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        case let .manuallyInvite(associatedValue0, browser):
            try container.encode("manuallyInvite", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.ManuallyInviteKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
            try subContainer.encode(encodeBrowser(browser), forKey: .browser)
        case let .didSendInvitation(associatedValue0):
            try container.encode("didSendInvitation", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.DidSendInvitationKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        case let .remoteAcceptedInvitation(associatedValue0):
            try container.encode("remoteAcceptedInvitation", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.RemoteAcceptedInvitationKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        case let .remoteDeclinedInvitation(associatedValue0, error):
            try container.encode("remoteDeclinedInvitation", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.RemoteDeclinedInvitationKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
            try subContainer.encode(encodeError(error), forKey: .error)
        }
    }
}
extension MultipeerSessionConnectivityAction: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum PeerConnectedKeys: String, CodingKey {
            case associatedValue0
        }
        enum PeerDisconnectedKeys: String, CodingKey {
            case associatedValue0
        }
        enum PeerIsConnectingKeys: String, CodingKey {
            case associatedValue0
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch try container.decode(String.self, forKey: .type) {
        case "startMonitoring":
            self = .startMonitoring
        case "stoppedMonitoring":
            self = .stoppedMonitoring
        case "peerConnected":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.PeerConnectedKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(Peer.self, forKey: .associatedValue0)
            self = .peerConnected(associatedValues0)
        case "peerDisconnected":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.PeerDisconnectedKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(Peer.self, forKey: .associatedValue0)
            self = .peerDisconnected(associatedValues0)
        case "peerIsConnecting":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.PeerIsConnectingKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(Peer.self, forKey: .associatedValue0)
            self = .peerIsConnecting(associatedValues0)
        default:
            throw DecodingError.keyNotFound(CodingKeys.type, .init(codingPath: container.codingPath, debugDescription: "Unknown key"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .startMonitoring:
            try container.encode("startMonitoring", forKey: .type)
        case .stoppedMonitoring:
            try container.encode("stoppedMonitoring", forKey: .type)
        case let .peerConnected(associatedValue0):
            try container.encode("peerConnected", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.PeerConnectedKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        case let .peerDisconnected(associatedValue0):
            try container.encode("peerDisconnected", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.PeerDisconnectedKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        case let .peerIsConnecting(associatedValue0):
            try container.encode("peerIsConnecting", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.PeerIsConnectingKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        }
    }
}
extension MultipeerSessionMessagingAction: Encodable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum GotDataKeys: String, CodingKey {
            case associatedValue0
            case from
        }
        enum SendDataKeys: String, CodingKey {
            case associatedValue0
        }
        enum SendDataToPeerKeys: String, CodingKey {
            case associatedValue0
            case to
        }
        enum SendDataResultKeys: String, CodingKey {
            case associatedValue0
            case to
            case result
        }
    }


    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .startMonitoring:
            try container.encode("startMonitoring", forKey: .type)
        case .stoppedMonitoring:
            try container.encode("stoppedMonitoring", forKey: .type)
        case let .gotData(associatedValue0, from):
            try container.encode("gotData", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.GotDataKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
            try subContainer.encode(from, forKey: .from)
        case let .sendData(associatedValue0):
            try container.encode("sendData", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.SendDataKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
        case let .sendDataToPeer(associatedValue0, to):
            try container.encode("sendDataToPeer", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.SendDataToPeerKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
            try subContainer.encode(to, forKey: .to)
        case let .sendDataResult(associatedValue0, to, result):
            try container.encode("sendDataResult", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.SendDataResultKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValue0, forKey: .associatedValue0)
            try subContainer.encode(to, forKey: .to)
            try subContainer.encode(encodeResult(result), forKey: .result)
        }
    }
}
