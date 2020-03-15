// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MultipeerRedux",
    platforms: [
        .iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(name: "MultipeerRedux", targets: ["MultipeerRedux"])
    ],
    dependencies: [
        .package(name: "MultipeerCombine", path: "../MultipeerCombine")
    ],
    targets: [
        .target(name: "MultipeerRedux", dependencies: ["MultipeerCombine"]),
        .testTarget(name: "MultipeerReduxTests", dependencies: ["MultipeerRedux"])
    ]
)
