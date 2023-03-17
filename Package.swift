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
                          ]),
        
        .binaryTarget(name: "App",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.0.2/App_debug.xcframework.zip",
                      checksum: "2161cb2c1b2cf080ae2b163259d481a5249429b8d0d12621becf4c2f936227a6"),
        
        .binaryTarget(name: "Flutter",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.0.2/Flutter_debug.xcframework.zip",
                      checksum: "8dea9d4969255bcde326199a0e084bdbe9211311ae5f7cb1b299b76d60de1479"),
                          
        .binaryTarget(name: "FlutterPluginRegistrant", 
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.0.2/FlutterPluginRegistrant.xcframework.zip",
                      checksum: "ad4ac990d7eee53314f4f114e13abb88f3c1c6fa49e5d0d1abcdcbf3f1833d58"),
        
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.0.2/flutter_secure_storage.xcframework.zip",
                      checksum: "98ff04a54f75846d85e36f92d4fce711eeeb67ab0b2d11dd2a5593894d38628b"),
        
        .binaryTarget(name: "path_provider_foundation",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.0.2/path_provider_foundation.xcframework.zip",
                      checksum: "b51977c41465a24659171b3045ea1f0c1d0b00c6576eaf9fd01ec9b79b60d065"),
        
        .binaryTarget(name: "sqlite3_flutter_libs",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.0.2/sqlite3_flutter_libs.xcframework.zip",
                    checksum: "9444fa90a62b690cfbdc993414cfe20496f77b729730d20b62d55e57c9e2ab63"),
        
        .binaryTarget(name: "sqlite3",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.0.2/sqlite3.xcframework.zip",
                      checksum: "ac85fd9f1b79f3fc50cef2a7f19a31fc29d337cbbebd63facba4a0ee3c0778fa"),
        ]
)

package.dependencies.append(
    .package(url: "https://github.com/SwiftPackageIndex/SPIManifest.git", from: "0.12.0")
)
