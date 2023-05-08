// swift-tools-version:5.5.0

import PackageDescription

let package = Package(
    name: "TikiSdk",
    platforms: [
            .iOS(.v15)
    ],
    products: [
        .library(
            name: "TikiSdk",
            targets: ["TikiSdk"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftPackageIndex/SPIManifest.git", from: "0.12.0"),
        .package(url: "https://github.com/gonzalezreal/swift-markdown-ui.git", from: "2.1.0")
    ],
    targets: [
        .target(
            name: "TikiSdk",
            dependencies: [
                           "App",
                           "flutter_secure_storage",
                           "Flutter",
                           "FlutterPluginRegistrant",
                           .product(name: "MarkdownUI", package: "swift-markdown-ui")
                          ],
            resources: [
                .process("Media.xcassets"),
                .process("Resources/learnMore.md")
            ]
        ),
        .binaryTarget(name: "App",
                      url: "https://github.com/tiki/tiki-sdk-platform-channel/releases/download/1.0.11/App.xcframework.zip",
                      checksum: "28ac8da55e884e1f734a4aad5be937ccbb4a6e83e92e31c2f7ed6417794a7cf6"),
        
        .binaryTarget(name: "Flutter",
                      url: "https://github.com/tiki/tiki-sdk-platform-channel/releases/download/1.0.11/Flutter.xcframework.zip",
                      checksum: "2585a53e3b545b01c5c3ead6573b2c6cb350295db65a528a6132824d99d68f13"),
                          
        .binaryTarget(name: "FlutterPluginRegistrant", 
                      url: "https://github.com/tiki/tiki-sdk-platform-channel/releases/download/1.0.11/FlutterPluginRegistrant.xcframework.zip",
                      checksum: "21674c00f0ff2213c3371205e80337a08838cbde3ea026a529e9fd3820da2b36"),
        
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-sdk-platform-channel/releases/download/1.0.11/flutter_secure_storage.xcframework.zip",
                      checksum: "cdde9748181e754ba9d1f7ac5189693d69fdb1006976853e91af98efd8d639f8"),
        
        ]
)
