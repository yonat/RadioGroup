// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "RadioGroup",
    platforms: [
        .iOS(.v9),
    ],
    products: [
        .library(name: "RadioGroup", targets: ["RadioGroup"]),
    ],
    dependencies: [
        .package(url: "https://github.com/yonat/SweeterSwift", from: "1.0.4"),
    ],
    targets: [
        .target(name: "RadioGroup", dependencies: ["SweeterSwift"], path: "Sources"),
    ],
    swiftLanguageVersions: [.v5]
)
