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
                           "path_provider_ios",
                           "sqlite3_flutter_libs",
                           "sqlite3",
                          ]),
        .binaryTarget(name: "App",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.17/App_release.xcframework.zip",
                      checksum: "7cddad9f12c44424a6f5bcebb5def5c6a63fac5f2a9f2de7760bbe913d43f154"),
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.17/flutter_secure_storage_release.xcframework.zip",
                      checksum: "41534db5f745cf91e39ea9f71f48d779be6d9e333a1979f7f473f52ad05681f9"),
        .binaryTarget(name: "Flutter",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.17/Flutter_release.xcframework.zip",
                      checksum: "a47dc055a7ea5b030eb63956b0371e41afc1acac2d04742817307ec9105c029d"),
        .binaryTarget(name: "FlutterPluginRegistrant",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.17/FlutterPluginRegistrant_release.xcframework.zip",
                      checksum: "c825ed9cf3c996978686ffb886603de64822dc622aa47a6a94ed9a687f007770"),
        .binaryTarget(name: "path_provider_ios",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.17/path_provider_ios_release.xcframework.zip",
                      checksum: "c202aad7fadf90d29b8e1b460b9513f7e19face8161bbd48c3c0fe10b5483436"),
        
        .binaryTarget(name: "sqlite3_flutter_libs",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.17/sqlite3_flutter_libs_release.xcframework.zip",
                      checksum: "6d28fcfea233c515be07adba6c76d235ee38aaf7e1a67e89c3d003596cc26f7f"),
        .binaryTarget(name: "sqlite3",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.17/sqlite3_release.xcframework.zip",
                      checksum: "fa2f20a4f473bf9b21f71b2d2697d7c12f05eb9a3b9912ad9ad8feb2a7ee5581"),
        .testTarget(
            name: "TikiSdkTests",
            dependencies: ["TikiSdk"]),
    ]
)
