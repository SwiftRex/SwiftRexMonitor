import Foundation

public struct MonitoredDevice: Codable, Equatable {
    public let deviceName: String
    public let deviceModel: String
    public let systemName: String
    public let systemVersion: String

    public init(
        deviceName: String,
        deviceModel: String,
        systemName: String,
        systemVersion: String
    ) {
        self.deviceName = deviceName
        self.deviceModel = deviceModel
        self.systemName = systemName
        self.systemVersion = systemVersion
    }
}
