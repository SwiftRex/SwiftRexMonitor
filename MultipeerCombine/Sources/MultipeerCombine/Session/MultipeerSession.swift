import Combine
import Foundation
import MultipeerConnectivity

public class MultipeerSession: NSObject, MCSessionDelegate {
    public let session: MCSession
    private let _messages = PassthroughSubject<MultipeerSessionReceivedMessage, Never>()
    private let _connections = PassthroughSubject<MultipeerSessionConnectionStatusEvent, Never>()

    public var messages: AnyPublisher<MultipeerSessionReceivedMessage, Never> {
        _messages.eraseToAnyPublisher()
    }

    public var connections: AnyPublisher<MultipeerSessionConnectionStatusEvent, Never> {
        _connections.eraseToAnyPublisher()
    }

    public init(myselfAsPeer: MCPeerID) {
        session = MCSession(peer: myselfAsPeer, securityIdentity: nil, encryptionPreference: .required)
        super.init()
        session.delegate = self
    }

    public func invite(peer: MCPeerID, browser: MCNearbyServiceBrowser, context: Data?, timeout: TimeInterval) -> AnyPublisher<MCPeerID, Never> {
        _connections
            .filter { event in
                guard case let .peerConnected(connectedPeer, _) = event else { return false }
                return connectedPeer == peer
            }
            .map { _ in peer }
            .handleEvents(receiveSubscription: { [weak self] _ in
                guard let self = self else { return }
                browser.invitePeer(peer, to: self.session, withContext: context, timeout: timeout)
            })
            .eraseToAnyPublisher()
    }

    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            _connections.send(.peerConnected(peerID, session: session))
        case .connecting:
            _connections.send(.peerIsConnecting(peerID, session: session))
        case .notConnected:
            _connections.send(.peerDisconnected(peerID, session: session))
        @unknown default: break
        }
    }

    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        _messages.send(.data(data, from: peerID, session: session))
    }

    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        _messages.send(.stream(stream, streamName: streamName, from: peerID, session: session))
    }

    public func session(
        _ session: MCSession,
        didStartReceivingResourceWithName resourceName: String,
        fromPeer peerID: MCPeerID,
        with progress: Progress
    ) {
        _messages.send(.didStartReceivingResource(resourceName: resourceName, from: peerID, progress: progress, session: session))
    }

    public func session(
        _ session: MCSession,
        didFinishReceivingResourceWithName resourceName: String,
        fromPeer peerID: MCPeerID,
        at localURL: URL?,
        withError error: Error?
    ) {
        _messages.send(.didFinishReceivingResource(resourceName: resourceName, from: peerID, localURL: localURL, error: error, session: session))
    }

    public func send(_ data: Data, to peer: MCPeerID, reliable: Bool = true) -> Result<Void, Error> {
        Result {
            try session.send(data, toPeers: [peer], with: reliable ? .reliable : .unreliable)
        }
    }

    public func sendToAll(_ data: Data, reliable: Bool = true) -> Result<Void, Error> {
        Result {
            try session.send(data, toPeers: session.connectedPeers, with: reliable ? .reliable : .unreliable)
        }
    }
}
