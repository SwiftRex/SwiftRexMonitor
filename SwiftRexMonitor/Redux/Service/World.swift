import AppKit
import Foundation
import MultipeerCombine
import MultipeerConnectivity
import MultipeerMiddleware
import SwiftRex
import SwiftRexMonitorEngine

struct World {
    let advertiserPublisher: (MCPeerID) -> MultipeerAdvertiserPublisher
    let browserPublisher: (MCPeerID) -> MultipeerBrowserPublisher
    let bundle: Bundle
    let copy: (String) -> Void
    let decoder: () -> JSONDecoder
    let encoder: () -> JSONEncoder
    let multipeerSession: () -> MultipeerSession
    let myselfAsPeer: () -> MCPeerID
    let store: () -> AnyStoreType<AppAction, AppState>
}

extension World {
    static let live: World = {
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
            copy: { string in
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setString(string, forType: .string)
            },
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
