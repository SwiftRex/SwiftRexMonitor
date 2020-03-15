import Foundation

public struct PeerMetadata: Codable, Equatable {
    public let installationId: ClientInstallationId
    public let monitoredApp: MonitoredApp
    public let monitoredDevice: MonitoredDevice

    public init(
        installationId: ClientInstallationId,
        monitoredApp: MonitoredApp,
        monitoredDevice: MonitoredDevice
    ) {
        self.installationId = installationId
        self.monitoredApp = monitoredApp
        self.monitoredDevice = monitoredDevice
    }
}
