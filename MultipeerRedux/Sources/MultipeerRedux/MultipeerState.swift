import Foundation

public struct MultipeerState: Encodable, Equatable {
    public var advertiser: MultipeerAdvertiserState
    public var browser: MultipeerBrowserState
}

extension MultipeerState {
    public static var empty: MultipeerState {
        .init(advertiser: .stopped, browser: .init())
    }
}
