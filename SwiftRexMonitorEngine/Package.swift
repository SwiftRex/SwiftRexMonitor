// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftRexMonitorEngine",
    platforms: [
        .iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(name: "SwiftRexMonitorEngine", targets: ["SwiftRexMonitorEngine"])
    ],
    dependencies: [
        .package(name: "MonitoredAppMiddleware", path: "../MonitoredAppMiddleware"),
        .package(name: "MultipeerMiddleware", url: "https://github.com/SwiftRex/MultipeerMiddleware.git", .branch("master"))
    ],
    targets: [
        .target(name: "SwiftRexMonitorEngine", dependencies: ["MultipeerMiddleware", "MonitoredAppMiddleware"]),
        .testTarget(name: "SwiftRexMonitorEngineTests", dependencies: ["SwiftRexMonitorEngine"])
    ]
)
