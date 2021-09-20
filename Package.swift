// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CountryKit",
    platforms: [
            .iOS(SupportedPlatform.IOSVersion.v11),
            .macOS(SupportedPlatform.MacOSVersion.v10_13)
        ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CountryKit",
            targets: ["CountryKit"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/cs4alhaider/Helper4Swift.git", .branch("master"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CountryKit",
            dependencies: ["Helper4Swift"],
            resources: [
                .process("countryCodes.json")
            ]),
        .testTarget(
            name: "CountryKitTests",
            dependencies: ["CountryKit", "Helper4Swift"]),
    ]
)
