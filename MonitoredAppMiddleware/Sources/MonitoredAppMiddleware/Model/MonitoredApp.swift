import Foundation

public struct MonitoredApp: Codable, Equatable {
    public let appName: String
    public let appVersion: String
    public let appIdentifier: String

    public init(
        appName: String,
        appVersion: String,
        appIdentifier: String
    ) {
        self.appName = appName
        self.appVersion = appVersion
        self.appIdentifier = appIdentifier
    }
}
