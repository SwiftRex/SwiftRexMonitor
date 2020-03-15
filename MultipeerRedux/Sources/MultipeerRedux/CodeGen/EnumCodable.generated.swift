// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import MultipeerConnectivity
extension MultipeerAction: Encodable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum AdvertiserKeys: String, CodingKey {
            case associatedValues0
        }
        enum BrowserKeys: String, CodingKey {
            case associatedValues0
        }
        enum ConnectivityKeys: String, CodingKey {
            case associatedValues0
        }
        enum MessagingKeys: String, CodingKey {
            case associatedValues0
        }
    }


    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .advertiser(associatedValues):
            try container.encode("advertiser", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.AdvertiserKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues, forKey: .associatedValues0)
        case let .browser(associatedValues):
            try container.encode("browser", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.BrowserKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues, forKey: .associatedValues0)
        case let .connectivity(associatedValues):
            try container.encode("connectivity", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.ConnectivityKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues, forKey: .associatedValues0)
        case let .messaging(associatedValues):
            try container.encode("messaging", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.MessagingKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues, forKey: .associatedValues0)
        }
    }
}
extension MultipeerAdvertiserAction: Encodable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum StoppedAdvertisingDueToErrorKeys: String, CodingKey {
            case associatedValues0
        }
        enum InvitedKeys: String, CodingKey {
            case associatedValues0 = "by"
            case associatedValues1 = "context"
        }
        enum AcceptedInvitationKeys: String, CodingKey {
            case associatedValues0 = "from"
            case associatedValues1 = "context"
        }
        enum DeclinedInvitationKeys: String, CodingKey {
            case associatedValues0 = "from"
            case associatedValues1 = "context"
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
        case let .stoppedAdvertisingDueToError(associatedValues):
            try container.encode("stoppedAdvertisingDueToError", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.StoppedAdvertisingDueToErrorKeys.self, forKey: .associatedValues)
            try subContainer.encode(encodeError(associatedValues), forKey: .associatedValues0)
        case let .invited(associatedValues):
            try container.encode("invited", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.InvitedKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues.by, forKey: .associatedValues0)
            try subContainer.encode(associatedValues.context, forKey: .associatedValues1)
        case let .acceptedInvitation(associatedValues):
            try container.encode("acceptedInvitation", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.AcceptedInvitationKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues.from, forKey: .associatedValues0)
            try subContainer.encode(associatedValues.context, forKey: .associatedValues1)
        case let .declinedInvitation(associatedValues):
            try container.encode("declinedInvitation", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.DeclinedInvitationKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues.from, forKey: .associatedValues0)
            try subContainer.encode(associatedValues.context, forKey: .associatedValues1)
        }
    }
}
extension MultipeerAdvertiserState: Encodable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum ErrorKeys: String, CodingKey {
            case associatedValues0
        }
    }


    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .advertising:
            try container.encode("advertising", forKey: .type)
        case .stopped:
            try container.encode("stopped", forKey: .type)
        case let .error(associatedValues):
            try container.encode("error", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.ErrorKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues, forKey: .associatedValues0)
        }
    }
}
extension MultipeerBrowserAction: Encodable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum StoppedBrowsingDueToErrorKeys: String, CodingKey {
            case associatedValues0
        }
        enum FoundPeerKeys: String, CodingKey {
            case associatedValues0
            case associatedValues1 = "info"
            case associatedValues2 = "browser"
        }
        enum LostPeerKeys: String, CodingKey {
            case associatedValues0
        }
        enum ManuallyInviteKeys: String, CodingKey {
            case associatedValues0
            case associatedValues1 = "browser"
        }
        enum DidSendInvitationKeys: String, CodingKey {
            case associatedValues0
        }
        enum RemoteAcceptedInvitationKeys: String, CodingKey {
            case associatedValues0
        }
        enum RemoteDeclinedInvitationKeys: String, CodingKey {
            case associatedValues0
            case associatedValues1 = "error"
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
        case let .stoppedBrowsingDueToError(associatedValues):
            try container.encode("stoppedBrowsingDueToError", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.StoppedBrowsingDueToErrorKeys.self, forKey: .associatedValues)
            try subContainer.encode(encodeError(associatedValues), forKey: .associatedValues0)
        case let .foundPeer(associatedValues):
            try container.encode("foundPeer", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.FoundPeerKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues.0, forKey: .associatedValues0)
            try subContainer.encode(associatedValues.info, forKey: .associatedValues1)
            try subContainer.encode(encodeBrowser(associatedValues.browser), forKey: .associatedValues2)
        case let .lostPeer(associatedValues):
            try container.encode("lostPeer", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.LostPeerKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues, forKey: .associatedValues0)
        case let .manuallyInvite(associatedValues):
            try container.encode("manuallyInvite", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.ManuallyInviteKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues.0, forKey: .associatedValues0)
            try subContainer.encode(encodeBrowser(associatedValues.browser), forKey: .associatedValues1)
        case let .didSendInvitation(associatedValues):
            try container.encode("didSendInvitation", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.DidSendInvitationKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues, forKey: .associatedValues0)
        case let .remoteAcceptedInvitation(associatedValues):
            try container.encode("remoteAcceptedInvitation", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.RemoteAcceptedInvitationKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues, forKey: .associatedValues0)
        case let .remoteDeclinedInvitation(associatedValues):
            try container.encode("remoteDeclinedInvitation", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.RemoteDeclinedInvitationKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues.0, forKey: .associatedValues0)
            try subContainer.encode(encodeError(associatedValues.error), forKey: .associatedValues1)
        }
    }
}
extension MultipeerSessionConnectivityAction: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum PeerConnectedKeys: String, CodingKey {
            case associatedValues0
        }
        enum PeerDisconnectedKeys: String, CodingKey {
            case associatedValues0
        }
        enum PeerIsConnectingKeys: String, CodingKey {
            case associatedValues0
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
            let associatedValues0 = try subContainer.decode(Peer.self, forKey: .associatedValues0)
            self = .peerConnected(associatedValues0)
        case "peerDisconnected":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.PeerDisconnectedKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(Peer.self, forKey: .associatedValues0)
            self = .peerDisconnected(associatedValues0)
        case "peerIsConnecting":
            let subContainer = try container.nestedContainer(keyedBy: CodingKeys.PeerIsConnectingKeys.self, forKey: .associatedValues)
            let associatedValues0 = try subContainer.decode(Peer.self, forKey: .associatedValues0)
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
        case let .peerConnected(associatedValues):
            try container.encode("peerConnected", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.PeerConnectedKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues, forKey: .associatedValues0)
        case let .peerDisconnected(associatedValues):
            try container.encode("peerDisconnected", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.PeerDisconnectedKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues, forKey: .associatedValues0)
        case let .peerIsConnecting(associatedValues):
            try container.encode("peerIsConnecting", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.PeerIsConnectingKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues, forKey: .associatedValues0)
        }
    }
}
extension MultipeerSessionMessagingAction: Encodable {
    enum CodingKeys: String, CodingKey {
        case type
        case associatedValues

        enum GotDataKeys: String, CodingKey {
            case associatedValues0
            case associatedValues1 = "from"
        }
        enum SendDataKeys: String, CodingKey {
            case associatedValues0
        }
        enum SendDataToPeerKeys: String, CodingKey {
            case associatedValues0
            case associatedValues1 = "to"
        }
        enum SendDataResultKeys: String, CodingKey {
            case associatedValues0
            case associatedValues1 = "to"
            case associatedValues2 = "result"
        }
    }


    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .startMonitoring:
            try container.encode("startMonitoring", forKey: .type)
        case .stoppedMonitoring:
            try container.encode("stoppedMonitoring", forKey: .type)
        case let .gotData(associatedValues):
            try container.encode("gotData", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.GotDataKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues.0, forKey: .associatedValues0)
            try subContainer.encode(associatedValues.from, forKey: .associatedValues1)
        case let .sendData(associatedValues):
            try container.encode("sendData", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.SendDataKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues, forKey: .associatedValues0)
        case let .sendDataToPeer(associatedValues):
            try container.encode("sendDataToPeer", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.SendDataToPeerKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues.0, forKey: .associatedValues0)
            try subContainer.encode(associatedValues.to, forKey: .associatedValues1)
        case let .sendDataResult(associatedValues):
            try container.encode("sendDataResult", forKey: .type)
            var subContainer = container.nestedContainer(keyedBy: CodingKeys.SendDataResultKeys.self, forKey: .associatedValues)
            try subContainer.encode(associatedValues.0, forKey: .associatedValues0)
            try subContainer.encode(associatedValues.to, forKey: .associatedValues1)
            try subContainer.encode(encodeResult(associatedValues.result), forKey: .associatedValues2)
        }
    }
}
