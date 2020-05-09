import Combine
import Foundation
import MultipeerCombine
import MultipeerConnectivity
import MultipeerMiddleware
import SwiftRex

public final class MonitoredAppMiddleware<Action, State: Encodable & Equatable>: Middleware {
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
        encoder: @escaping () -> JSONEncoder = sortedOrderEncoder
    ) {
        let name = "\(appName()) 📱 \(deviceName())"
        let myselfAsPeer = MCPeerID(displayName: name)

        self.session = multipeerSession?() ?? .init(myselfAsPeer: myselfAsPeer)

        self.advertiser = advertiser ?? { .init(myselfAsPeer: myselfAsPeer, serviceType: serviceType()) }
        self.encoder = encoder
        self.session.connections.sink { event in
            switch event {
            case let .peerConnected(monitor, _):
                self.sayHello(peer: monitor)
            case .peerDisconnected, .peerIsConnecting:
                break
            }
        }.store(in: &cancellables)
    }

    public func receiveContext(getState: @escaping GetState<StateType>, output: AnyActionHandler<OutputActionType>) {
        self.getState = getState
        self.output = output

        advertiser().assertNoFailure().sink { [unowned self] event in
            switch event {
            case let .didReceiveInvitationFromPeer(_, _, handler):
                handler(true, self.session.session)
            }
        }.store(in: &cancellables)
    }

    public func handle(action: InputActionType, from dispatcher: ActionSource, afterReducer: inout AfterReducer) {
        let oldState = getState?()
        afterReducer = .do {
            let newState = self.getState?()
            self.sendAction(action: action, from: dispatcher, changedState: oldState == newState ? nil : newState)
        }
    }

    private func sayHello(peer: MCPeerID) {
        send(message:
            MessageType.introduction(
                PeerMetadata(
                    installationId: ClientInstallationId(rawValue: installationId())!,
                    monitoredApp: .init(
                        appName: appName(),
                        appVersion: appVersion(),
                        appIdentifier: bundleId()
                    ),
                    monitoredDevice: .init(
                        deviceName: deviceName(),
                        deviceModel: deviceModel(),
                        systemName: systemName(),
                        systemVersion: systemVersion()
                    ),
                    initialState: (getState?()).flatMap(parseState) ?? Data()
                )
            )
        )
    }

    private func sendAction(action: InputActionType, from dispatcher: ActionSource, changedState: State?) {
        send(message:
            MessageType.action(
                ActionMessage(
                    remoteDate: Date(),
                    action: "\(action)",
                    state: changedState.flatMap(parseState),
                    actionSource: dispatcher
                )
            )
        )
    }

    private func parseState(state: State) -> Data? {
        try? encoder().encode(state)
    }

    private func send(message: MessageType) {
        if case let .failure(error) = Result
            .init(catching: { try encoder().encode(message) })
            .flatMap({ session.sendToAll($0) }) {
            print("codable error \(error)")
        }
    }
}

extension MonitoredAppMiddleware {
    public static func sortedOrderEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .withoutEscapingSlashes]
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }
}

private func mainBundle() -> Bundle { Bundle.main }
private func serviceType() -> String { "swiftrex-mon" }
private func appName() -> String { mainBundle().infoDictionary?["CFBundleName"] as? String ?? "" }
private func bundleId() -> String { mainBundle().bundleIdentifier ?? "?" }
private func appVersion() -> String { "\(shortVersionNumber()) (\(longVersionNumber())" }
private func shortVersionNumber() -> String { mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String ?? "" }
private func longVersionNumber() -> String { mainBundle().infoDictionary?["CFBundleVersion"] as? String ?? "" }

#if os(iOS) || os(tvOS) || os(watchOS)

#if canImport(UIKit)
import UIKit
#endif
#if canImport(WatchKit)
import WatchKit
#endif

private func deviceName() -> String { UIDevice.current.name }
private func deviceModel() -> String { UIDevice.current.localizedModel }
private func systemName() -> String { UIDevice.current.systemName }
private func systemVersion() -> String { UIDevice.current.systemVersion }
private func installationId() -> String { UIDevice.current.identifierForVendor?.uuidString ?? "\(appName())@?" }

#else

import Cocoa
private func deviceName() -> String { Host.current().localizedName ?? "Mac" }
private func deviceModel() -> String { "Some Mac" }
private func systemName() -> String { "macOS" }
private func systemVersion() -> String { ProcessInfo.processInfo.operatingSystemVersionString }
private func installationId() -> String { "\(appName())@\(mainMacAddress() ?? "?")" }

private func mainMacAddress() -> String? {
    try? findEthernetInterfaces()
        .flatMap { interfaceIterator -> Result<[UInt8], Error> in
            defer {
                IOObjectRelease(interfaceIterator)
            }

            return macAddress(interfaces: interfaceIterator)
        }.map { macAddress in
            macAddress
                .map { String(format: "%02x", $0) }
                .joined(separator: ":")
        }.get()
}

// Returns an iterator containing the primary (built-in) Ethernet interface. The caller is responsible for
// releasing the iterator after the caller is done with it.
private func findEthernetInterfaces() -> Result<io_iterator_t, Error> {
    let matchingDictUM = IOServiceMatching("IOEthernetInterface")
    // Note that another option here would be:
    // matchingDict = IOBSDMatching("en0");
    // but en0: isn't necessarily the primary interface, especially on systems with multiple Ethernet ports.

    guard let matchingDict = matchingDictUM as NSMutableDictionary? else {
        return .failure(NSError.init(domain: "Invalid IOEthernetInterface dictionary", code: -1, userInfo: nil))
    }
    matchingDict["IOPropertyMatch"] = ["IOPrimaryInterface": true]

    var matchingServices: io_iterator_t = 0
    if IOServiceGetMatchingServices(kIOMasterPortDefault, matchingDict, &matchingServices) != KERN_SUCCESS {
        return .failure(NSError.init(domain: "Invalid result of IOServiceGetMatchingServices", code: -1, userInfo: nil))
    }

    return .success(matchingServices)
}

// Given an iterator across a set of Ethernet interfaces, return the MAC address of the last one.
// If no interfaces are found the MAC address is set to an empty string.
// In this sample the iterator should contain just the primary interface.
private func macAddress(interfaces: io_iterator_t) -> Result<[UInt8], Error> {
    var macAddress: [UInt8]?
    var intfService = IOIteratorNext(interfaces)
    while intfService != 0 {
        var controllerService: io_object_t = 0
        if IORegistryEntryGetParentEntry(intfService, "IOService", &controllerService) == KERN_SUCCESS {

            if let dataUM = IORegistryEntryCreateCFProperty(controllerService, "IOMACAddress" as CFString, kCFAllocatorDefault, 0),
                let data = dataUM.takeRetainedValue() as? NSData {
                macAddress = [0, 0, 0, 0, 0, 0]
                data.getBytes(&macAddress!, length: macAddress!.count)
            }
            IOObjectRelease(controllerService)
        }

        IOObjectRelease(intfService)
        intfService = IOIteratorNext(interfaces)
    }

    return macAddress.map(Result.success) ?? .failure(NSError.init(domain: "Invalid interface MAC Address", code: -1, userInfo: nil))
}
#endif
