import Combine
import Foundation
import MultipeerCombine
import MultipeerConnectivity
import MultipeerMiddleware
import SwiftRex

public final class MonitoredAppMiddleware<Action, State>: Middleware {
    public typealias InputActionType = Action
    public typealias OutputActionType = Action
    public typealias StateType = State

    private var output: AnyActionHandler<OutputActionType>?
    private var getState: GetState<StateType>?
    private var cancellables = Set<AnyCancellable>()
    private let session: MultipeerSession
    private let advertiser: () -> MultipeerAdvertiserPublisher
    private let encoder: () -> JSONEncoder

    public init(
        multipeerSession: (() -> MultipeerSession)? = nil,
        advertiser: (() -> MultipeerAdvertiserPublisher)? = nil,
        encoder: @escaping () -> JSONEncoder = JSONEncoder.init
    ) {
        let bundle = Bundle.main
        let serviceType = "swiftrex-mon"
        let name = bundle.infoDictionary?["CFBundleName"] as? String ?? ""
        let myselfAsPeer = MCPeerID(displayName: name)

        self.session = multipeerSession?() ?? .init(myselfAsPeer: myselfAsPeer)
        self.advertiser = advertiser ?? { .init(myselfAsPeer: myselfAsPeer, serviceType: serviceType) }
        self.encoder = encoder
    }

    public func receiveContext(getState: @escaping GetState<StateType>, output: AnyActionHandler<OutputActionType>) {
        self.getState = getState
        self.output = output

        advertiser().assertNoFailure().sink { [unowned self] event in
            switch event {
            case let .didReceiveInvitationFromPeer(peer, _, handler):
                handler(true, self.session.session)
                self.sayHello(peer: peer)
            }
        }.store(in: &cancellables)
    }

    public func handle(action: InputActionType, from dispatcher: ActionSource, afterReducer: inout AfterReducer) {
        afterReducer = .do {
            self.sendAction(action: action, from: dispatcher)
        }
    }

    private func sayHello(peer: MCPeerID) {
        send(message:
            MessageType.introduction(
                PeerMetadata(
                    installationId: ClientInstallationId(rawValue: "123")!,
                    monitoredApp: .init(appName: "Test app", appVersion: "1.0", appIdentifier: "bundle"),
                    monitoredDevice: .init(deviceName: "iPhone", deviceModel: "X", systemName: "iOS", systemVersion: "13.0")
                )
            )
        )
    }

    private func sendAction(action: InputActionType, from dispatcher: ActionSource) {
        send(message:
            MessageType.action(
                ActionMessage(
                    remoteDate: Date(),
                    action: "\(action)",
                    actionPayload: .unkeyed(""),
                    state: .unkeyed(""),
                    actionSource: dispatcher
                )
            )
        )
    }

    private func send(message: MessageType) {
        switch Result(catching: { try encoder().encode(message) }) {
        case let .success(data):
            print(session.sendToAll(data))
        case let .failure(error):
            print("codable error \(error)")
        }
    }
}
