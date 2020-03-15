import Foundation
import SwiftRex

public let multipeerAdvertiserReducer = Reducer<MultipeerAdvertiserAction, MultipeerAdvertiserState> { action, state in
    switch action {
    case .startedAdvertising:
        return .advertising
    case .stoppedAdvertising:
        return .stopped
    case let .stoppedAdvertisingDueToError(error):
        return .error(MultipeerAdvertiserError(innerError: error))
    case .startAdvertising,
         .stopAdvertising,
         .invited,
         .acceptedInvitation,
         .declinedInvitation:
        return state
    }
}
