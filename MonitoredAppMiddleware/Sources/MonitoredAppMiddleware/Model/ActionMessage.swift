import Foundation
import SwiftRex

public struct ActionMessage: Codable, Equatable {
    public let remoteDate: Date
    public let action: String
    public let state: Data?
    public let actionSource: ActionSource
}
