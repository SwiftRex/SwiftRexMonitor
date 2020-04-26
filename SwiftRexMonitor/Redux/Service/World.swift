import Foundation
import MultipeerCombine
import MultipeerConnectivity
import MultipeerMiddleware
import SwiftRex

public struct World {
    public let advertiserPublisher: (MCPeerID) -> MultipeerAdvertiserPublisher
    public let browserPublisher: (MCPeerID) -> MultipeerBrowserPublisher
    public let bundle: Bundle
    public let decoder: () -> JSONDecoder
    public let encoder: () -> JSONEncoder
    public let multipeerSession: () -> MultipeerSession
    public let myselfAsPeer: () -> MCPeerID
    public let store: () -> AnyStoreType<AppAction, AppState>
}

extension World {
    public static let live: World = {
        let bundle = Bundle.main
        let serviceType = "swiftrex-mon"
        let name = bundle.infoDictionary?["CFBundleName"] as? String ?? ""
        let myselfAsPeer = MCPeerID(displayName: name)

        let browser = { MultipeerBrowserPublisher(myselfAsPeer: $0, serviceType: serviceType) }
        let advertiser = { MultipeerAdvertiserPublisher(myselfAsPeer: $0, serviceType: serviceType) }
        let session = MultipeerSession(myselfAsPeer: myselfAsPeer)
        var storeInstance: AnyStoreType<AppAction, AppState>?

        return World(
            advertiserPublisher: advertiser,
            browserPublisher: browser,
            bundle: bundle,
            decoder: {
                let d = JSONDecoder()
                d.dateDecodingStrategy = .iso8601
                return d
            },
            encoder: {
                let e = JSONEncoder()
                e.dateEncodingStrategy = .iso8601
                e.outputFormatting = [.sortedKeys, .withoutEscapingSlashes]
                return e
            },
            multipeerSession: { session },
            myselfAsPeer: { myselfAsPeer },
            store: {
                if let instance = storeInstance { return instance }
                storeInstance = createStore(world: .live)
                return storeInstance!
            }
        )
    }()
}
