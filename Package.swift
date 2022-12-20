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
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.23/App_debug.xcframework.zip",
//                      //checksum: "b45f94d0a4fec948086ae914dae851691c16e1588205108758821a3714a1e26d"), // release - production
                      checksum: "2f4f281278d4664bc946a7656f274169d86b0443dc86339ab79ee10d0b25dace"), // debug - testing
                          
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.23/flutter_secure_storage.xcframework.zip",
                      checksum: "519b5f7f732132ac150790fb454807ed2f9754fcaf90e4be1ed27e0ffaaddea5"),
        
        .binaryTarget(name: "Flutter",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.23/Flutter.xcframework.zip",
                      checksum: "2fc172d14fa8aeccdebb9b8e1dc45987f891e31a378b2b2ffde0ca2dbbd52b69"),
        
        .binaryTarget(name: "FlutterPluginRegistrant",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.23/FlutterPluginRegistrant.xcframework.zip",
                      checksum: "0c1b7e4ef296511befde3bbd082829e13ce92e6debbf9a323bf20a43c66b6b8a"),
        
        .binaryTarget(name: "path_provider_ios",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.23/path_provider_ios.xcframework.zip",
                      checksum: "df0e451aa4e2114a8235a27ade3b0d8b707f259e19284665897f00a0394bd1d0"),
        
        .binaryTarget(name: "sqlite3_flutter_libs",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.23/sqlite3_flutter_libs.xcframework.zip",
                    checksum: "8daea627a965c295bf4e64e0f7cf418d4c3697a6ffad54c477c9ca1a1ffd1be2"),
        
        .binaryTarget(name: "sqlite3",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.23/sqlite3.xcframework.zip",
                      checksum: "70cf1ea34007eea177d12c47627dc378b19ac20db3f3afe7100eb272bc692a91"),
        ]
)
