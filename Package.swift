// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ScenesShell",
    dependencies: [
      .package(url: "https://github.com/roboticsDev1584/NewIgis.git", from: "2.0.0"),
      .package(url: "https://github.com/TheCoderMerlin/Scenes.git", from: "1.0.10")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
          name: "ScenesShell"
        ),
    ]
)
