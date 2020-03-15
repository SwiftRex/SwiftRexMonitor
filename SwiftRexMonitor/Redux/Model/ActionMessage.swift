import Foundation
import SwiftRex

public struct ActionMessage: Codable, Equatable {
    public let action: String
    public let actionPayload: PayloadTree
    public let state: PayloadTree
    public let actionSource: ActionSource

}
