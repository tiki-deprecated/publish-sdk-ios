// swift-tools-version:5.5.0

import PackageDescription

let package = Package(
    name: "TikiSdk",
    platforms: [
            .iOS(.v14)
    ],
    products: [
        .library(
            name: "TikiSdk",
            targets: ["TikiSdk"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "TikiSdk",
            dependencies: [
                           "App",
                           "flutter_secure_storage",
                           "Flutter",
                           "FlutterPluginRegistrant",
                           "path_provider_foundation",
                           "sqlite3_flutter_libs",
                           "sqlite3",
                          ],
            resources: [
                .process("Media.xcassets"),
                .process("Resources/learnMore.md")
            ]
        ),
        
        .binaryTarget(name: "App",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.4/App.xcframework.zip",
                      checksum: "cc5ae619b793f1cfd476dce3b319173c369931bc874922fd2e2a5c9fef7662e8"),
        
        .binaryTarget(name: "Flutter",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.4/Flutter.xcframework.zip",
                      checksum: "d171082c4376800d34f27ef7e4465f375637599c3974876fda02acba19a2b32d"),
                          
        .binaryTarget(name: "FlutterPluginRegistrant", 
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.4/FlutterPluginRegistrant.xcframework.zip",
                      checksum: "6bf7791c3e6f66ae7ba1cc0411cf218ae1e27a1c4f63d950333522cf042af467"),
        
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.4/flutter_secure_storage.xcframework.zip",
                      checksum: "3820e93940975f50585aba0c4a96e08e30cc5f6b84fbeba509a188a7ce19af6d"),
        
        .binaryTarget(name: "path_provider_foundation",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.4/path_provider_foundation.xcframework.zip",
                      checksum: "7746a58897b6ccf4c1e4d5d207f5b27b58d96b641a76c76da7685d5c3f6f2cd2"),
        
        .binaryTarget(name: "sqlite3_flutter_libs",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.4/sqlite3_flutter_libs.xcframework.zip",
                    checksum: "65f741cbbcca1bfaea66ab127530a327efef3d763d055bdf217e4ff5025afbae"),
        
        .binaryTarget(name: "sqlite3",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.4/sqlite3.xcframework.zip",
                      checksum: "722bac9c5ab7cb768f9a997eeedeb41fd9e867d2d9b51cebec9af25274aee8e5"),
        ]
)

package.dependencies.append(
    .package(url: "https://github.com/SwiftPackageIndex/SPIManifest.git", from: "0.12.0")
)
