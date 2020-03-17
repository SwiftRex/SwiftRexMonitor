import Foundation
import MultipeerCombine
import MultipeerConnectivity
import MultipeerMiddleware
import SwiftRex

public struct World {
    public let bundle: Bundle
    public let advertiserPublisher: (MCPeerID) -> MultipeerAdvertiserPublisher
    public let browserPublisher: (MCPeerID) -> MultipeerBrowserPublisher
    public let myselfAsPeer: () -> MCPeerID
    public let multipeerSession: () -> MultipeerSession
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
            bundle: bundle,
            advertiserPublisher: advertiser,
            browserPublisher: browser,
            myselfAsPeer: { myselfAsPeer },
            multipeerSession: { session },
            store: {
                if let instance = storeInstance { return instance }
                storeInstance = createStore(world: .live)
                return storeInstance!
            }
        )
    }()
}
