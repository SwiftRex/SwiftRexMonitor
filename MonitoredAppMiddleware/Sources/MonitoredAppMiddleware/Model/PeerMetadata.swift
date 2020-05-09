import Foundation

public struct PeerMetadata: Codable, Equatable {
    public let installationId: ClientInstallationId
    public let monitoredApp: MonitoredApp
    public let monitoredDevice: MonitoredDevice
    public let initialState: Data

    public init(
        installationId: ClientInstallationId,
        monitoredApp: MonitoredApp,
        monitoredDevice: MonitoredDevice,
        initialState: Data
    ) {
        self.installationId = installationId
        self.monitoredApp = monitoredApp
        self.monitoredDevice = monitoredDevice
        self.initialState = initialState
    }
}
