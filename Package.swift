// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MonitoredAppMiddleware",
    platforms: [
        .iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(name: "MonitoredAppMiddleware", type: .dynamic, targets: ["MonitoredAppMiddleware"])
    ],
    dependencies: [
        .package(name: "MultipeerMiddleware", url: "https://github.com/SwiftRex/MultipeerMiddleware.git", .branch("master"))
    ],
    targets: [
        .target(name: "MonitoredAppMiddleware", dependencies: ["MultipeerMiddleware"], path: "MonitoredAppMiddleware/Sources/MonitoredAppMiddleware"),
        .testTarget(name: "MonitoredAppMiddlewareTests", dependencies: ["MonitoredAppMiddleware"])
    ]
)
