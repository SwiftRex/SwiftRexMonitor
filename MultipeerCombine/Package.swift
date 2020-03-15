// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MultipeerCombine",
    platforms: [
        .iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(name: "MultipeerCombine", targets: ["MultipeerCombine"])
    ],
    dependencies: [],
    targets: [
        .target(name: "MultipeerCombine", dependencies: []),
        .testTarget(name: "MultipeerCombineTests", dependencies: ["MultipeerCombine"])
    ]
)
