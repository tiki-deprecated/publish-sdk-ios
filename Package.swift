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
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.2/App_debug.xcframework.zip",
                      checksum: "0199ca4fd952a4814886b7c48398b7b165f2926965ee28c716e1f6ceaaeed511"),
        
        .binaryTarget(name: "Flutter",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.2/Flutter_debug.xcframework.zip",
                      checksum: "e28e905762f434ed055071705a1a7e1c3bda35581e42b6c654279de1266d5442"),
                          
        .binaryTarget(name: "FlutterPluginRegistrant", 
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.2/FlutterPluginRegistrant.xcframework.zip",
                      checksum: "b5195d84c5e44d77fe491403e382354e29b11dd722ecdc9dc70569b48441f931"),
        
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.2/flutter_secure_storage.xcframework.zip",
                      checksum: "65f5817653213365af53337aeca5396d41264ce2ed870b05448793f415f36fd7"),
        
        .binaryTarget(name: "path_provider_foundation",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.2/path_provider_foundation.xcframework.zip",
                      checksum: "ac48d171b014e266b6050109bfa988a928a587b70cf8002a9f59e931333d4473"),
        
        .binaryTarget(name: "sqlite3_flutter_libs",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.2/sqlite3_flutter_libs.xcframework.zip",
                    checksum: "f04f22b364eea2d2b9478edd690a54206467bfbf4c364c3a18edda7bd07f4915"),
        
        .binaryTarget(name: "sqlite3",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.2/sqlite3.xcframework.zip",
                      checksum: "ee9de5774e0ba2fc64d81aa31f8f568dabb45a22ce61cd906380b11e202926b6"),
        ]
)

package.dependencies.append(
    .package(url: "https://github.com/SwiftPackageIndex/SPIManifest.git", from: "0.12.0")
)
