// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MonitoredAppMiddleware",
    platforms: [
        .iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(name: "MonitoredAppMiddleware", targets: ["MonitoredAppMiddleware"])
    ],
    dependencies: [
        .package(name: "MultipeerCombine", path: "../MultipeerCombine"),
        .package(name: "MultipeerRedux", path: "../MultipeerRedux"),
        .package(name: "CombineRex", url: "https://github.com/SwiftRex/SwiftRex.git", from: "0.7.0")
    ],
    targets: [
        .target(name: "MonitoredAppMiddleware", dependencies: ["MultipeerCombine", "MultipeerRedux", "CombineRex"]),
        .testTarget(name: "MonitoredAppMiddlewareTests", dependencies: ["MonitoredAppMiddleware"])
    ]
)