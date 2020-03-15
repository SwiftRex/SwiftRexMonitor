import Foundation
import SwiftRex

public struct ActionMessage: Codable, Equatable {
    public let remoteDate: Date
    public let action: String
    public let actionPayload: PayloadTree
    public let state: PayloadTree
    public let actionSource: ActionSource
}
