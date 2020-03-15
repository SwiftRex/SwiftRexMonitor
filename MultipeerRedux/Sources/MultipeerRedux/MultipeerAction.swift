import Foundation

// sourcery: EnumCodable=EncodeOnly
// sourcery: Prism
public enum MultipeerAction {
    case advertiser(MultipeerAdvertiserAction)
    case browser(MultipeerBrowserAction)
    case connectivity(MultipeerSessionConnectivityAction)
    case messaging(MultipeerSessionMessagingAction)
}
