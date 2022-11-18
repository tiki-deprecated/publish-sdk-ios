// swift-tools-version:5.5.0

import PackageDescription

let package = Package(
    name: "TikiSdk",
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
                           "FBLPromises",
                           "flutter_secure_storage",
                           "Flutter",
                           "FlutterPluginRegistrant",
                           "path_provider_ios",
                           "Promises",
                           "sqlite3_flutter_libs",
                           "sqlite3",
                          ]),
        
        .binaryTarget(name: "FBLPromises",
                   url: "https://github.com/tiki/tiki-sdk-ios/raw/main/Frameworks/FBLPromises.xcframework.zip",
                   checksum: "af2f8e364f3625fa424f9978d4cf872e29fade272cc9ba5f1d10f9fa264add5d"),
        .binaryTarget(name: "Promises",
                      url: "https://github.com/tiki/tiki-sdk-ios/raw/main/Frameworks/Promises.xcframework.zip",
                      checksum: "5dd93eb33ad198c16595fcd3a1d97847496d5ccb5cae9ef660b0a3a0538cd4cf"),
        .binaryTarget(name: "path_provider_ios",
                      url: "https://github.com/tiki/tiki-sdk-ios/raw/main/Frameworks/path_provider_ios.xcframework.zip",
                      checksum: "e84e9b328f26abd56bcca2b8bdcf0205313b2f3b8d64cea2f67fb58f3124b11e"),

        
        .binaryTarget(name: "sqlite3_flutter_libs",
                      url: "https://github.com/tiki/tiki-sdk-ios/raw/main/Frameworks/sqlite3_flutter_libs.xcframework.zip",
                      checksum: "e052c42d71abf96b3d4558136f57936f1995be9c4afc760ed4626b052f17f873"),
        .binaryTarget(name: "sqlite3",
                      url: "https://github.com/tiki/tiki-sdk-ios/raw/main/Frameworks/sqlite3.xcframework.zip",
                      checksum: "376d4610702678a48cb9bea34f9fe60d4e4d226a167be7419b78119c230ca06e"),
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-sdk-ios/raw/main/Frameworks/flutter_secure_storage.xcframework.zip",
                      checksum: "cf8c8ed632b6685259292572cf7b9c9df6b1867a28f4ba4ca1c6371fbdb71e99"),
        .binaryTarget(name: "Flutter",
                      url: "https://github.com/tiki/tiki-sdk-ios/raw/main/Frameworks/Flutter.xcframework.zip",
                      checksum: "5f2a17156361a62a1a9aa0237d9c17095cda808b1733dec82546e39e841d07d2"),
        .binaryTarget(name: "FlutterPluginRegistrant",
                      url: "https://github.com/tiki/tiki-sdk-ios/raw/main/Frameworks/FlutterPluginRegistrant.xcframework.zip",
                      checksum: "a53db7c12bebc32b47a913859bf03b14cb3350e54450c372df9bde141852a1ce"),
        
        
        .binaryTarget(name: "App",
                      url: "https://github.com/tiki/tiki-sdk-ios/raw/main/Frameworks/App.xcframework.zip",
                      checksum: "9d9f34972c0b2b13fe87e4f0bd31ab3e4572601c57caa93ca2d9eb77de8b4e7c"),
//        .binaryTarget(name: "tiki_sdk_flutter_plugin",
//                      url: "https://github.com/tiki/tiki-sdk-ios/raw/main/Frameworks/tiki_sdk_flutter_plugin.xcframework.zip",
//                      checksum: "3451c64865ad58040af78845057ba8b0a31606b80dd816f2b3ca847c5dbbda47"),

        .testTarget(
            name: "TikiSdkTests",
            dependencies: ["TikiSdk"]),
    ]
)
