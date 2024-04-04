// swift-tools-version: 5.7
import PackageDescription

let package = Package(
  name: "TypewriterCarouselView",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(
      name: "TypewriterCarouselView",
      targets: ["TypewriterCarouselView"]
    )
  ],
  dependencies: [],
  targets: [
    .target(
      name: "TypewriterCarouselView",
      dependencies: []
    )
  ]
)
