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
                      checksum: "189e17140a3a0d2c5de640e68e127b864ac0c9e3db3deeab9d952353bfedfdb1"),
        
        .binaryTarget(name: "Flutter",
                      url: "https://github.com/tiki/tiki-sdk-platform-channel/releases/download/1.0.11/Flutter.xcframework.zip",
                      checksum: "cda81dce3e127ac52918e2cbd2c7249be25720c1f6e93b9a6aa48678235faf69"),
                          
        .binaryTarget(name: "FlutterPluginRegistrant", 
                      url: "https://github.com/tiki/tiki-sdk-platform-channel/releases/download/1.0.11/FlutterPluginRegistrant.xcframework.zip",
                      checksum: "21674c00f0ff2213c3371205e80337a08838cbde3ea026a529e9fd3820da2b36"),
        
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-sdk-platform-channel/releases/download/1.0.11/flutter_secure_storage.xcframework.zip",
                      checksum: "cdde9748181e754ba9d1f7ac5189693d69fdb1006976853e91af98efd8d639f8"),
        
        ]
)
