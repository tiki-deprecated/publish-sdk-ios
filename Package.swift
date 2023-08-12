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
                      path: "Frameworks/Debug/App.xcframework"),
//                      url: "https://github.com/tiki/tiki-trail-platform-channel/releases/download/2.0.6/App_debug.xcframework.zip",
//                      checksum: "ecbc93e7fba18a51477d8e0281df200fde15c746618d8eae49f8bc6cb5ebb10d"),
        
        .binaryTarget(name: "Flutter",
                      path: "Frameworks/Debug/Flutter.xcframework"),
//                      url: "https://github.com/tiki/tiki-trail-platform-channel/releases/download/2.0.6/Flutter_debug.xcframework.zip",
//                      checksum: "d498f043eea037eb21fb0c23763585f67fb653581921f9763110faf3c1c85097"),
                          
        .binaryTarget(name: "FlutterPluginRegistrant",
                      path: "Frameworks/Debug/FlutterPluginRegistrant.xcframework"),
//                      url: "https://github.com/tiki/tiki-trail-platform-channel/releases/download/2.0.6/FlutterPluginRegistrant_debug.xcframework.zip",
//                      checksum: "ea933a1cb47d9508628ea243f5eeb0dc8e62b51ce0382a6c69821ec08613bc1d"),
        
        .binaryTarget(name: "flutter_secure_storage",
                      path: "Frameworks/Debug/flutter_secure_storage.xcframework"),
//                      url: "https://github.com/tiki/tiki-trail-platform-channel/releases/download/2.0.6/flutter_secure_storage_debug.xcframework.zip",
//                      checksum: "3c17e0ed9d615fcba34b131f9a6acad81f8f2807d929998ef51923fc19c79fc8"),
        
        ]
)
