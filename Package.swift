// swift-tools-version: 5.4

import PackageDescription

let package = Package(
  name: "SwiftUIIf",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v13),
    .tvOS(.v13),
    .watchOS(.v7),
    .visionOS(.v1),
  ],
  products: [
    .library(
      name: "SwiftUIIf",
      targets: ["SwiftUIIf"]
    )
  ],
  targets: [
    .target(
      name: "SwiftUIIf"
    )
  ]
)
