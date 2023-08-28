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
                      url: "https://github.com/tiki/tiki-trail-platform-channel/releases/download/2.1.0/App_debug.xcframework.zip",
                      checksum: "a28b9ac49ef9a9f3fb59cb75553ab2901f5ff997003ee799dd8e29f70ec41733"),
        
        .binaryTarget(name: "Flutter",
                      url: "https://github.com/tiki/tiki-trail-platform-channel/releases/download/2.1.0/Flutter_debug.xcframework.zip",
                      checksum: "998644e57af7dbccb9d147fe0f1cba1a2fca4b048ddca4193420373d7fe5da6e"),
                          
        .binaryTarget(name: "FlutterPluginRegistrant",
                      url: "https://github.com/tiki/tiki-trail-platform-channel/releases/download/2.1.0/FlutterPluginRegistrant_debug.xcframework.zip",
                      checksum: "bd1282fe9455e4ead8c925214231f329360c8b413504bbcdb3cdb9a95283fb66"),
        
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-trail-platform-channel/releases/download/2.1.0/flutter_secure_storage_debug.xcframework.zip",
                      checksum: "c0ec1b0dc36e92b84c88ba149aab6c3e668b2a93e630d6bfe2399970218212fb"),
        ]
)
