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
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.20/App_debug.xcframework.zip",
                      //checksum: "b45f94d0a4fec948086ae914dae851691c16e1588205108758821a3714a1e26d"), // release - production
                      checksum: "8ce19771c7a65b2ed52c47708053bc5c66315dca7eb33c1ee1751bccc6297dd7"), // debug - testing
                          
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.20/flutter_secure_storage_release.xcframework.zip",
                      checksum: "53aa9903d25338f88b4c79cbae7be817bd0142cefdc0f9100485b43036567344"),
        
        .binaryTarget(name: "Flutter",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.20/Flutter_release.xcframework.zip",
                      checksum: "8c54ea3394f1f918cd18a06caf663fdc893ce6a765cc8fac1b0ace7f0a5cfe36"),
        
        .binaryTarget(name: "FlutterPluginRegistrant",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.20/FlutterPluginRegistrant_release.xcframework.zip",
                      checksum: "353734413d43606df20a29afd833ea605de3bde2f0d3fa994794c3007de120f7"),
        
        .binaryTarget(name: "path_provider_ios",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.20/path_provider_ios_release.xcframework.zip",
                      checksum: "bfbb511c9cdb3c25e6d8c13732998f32df7a018a60c133e07cfbb4ff4f1e0655"),
        
        .binaryTarget(name: "sqlite3_flutter_libs",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.20/sqlite3_flutter_libs_release.xcframework.zip",
                    checksum: "3695f2056600725d1e6f89e391737798fb6420011229bf2d6628dab4f0b86f71"),
        
        .binaryTarget(name: "sqlite3",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.20/sqlite3_release.xcframework.zip",
                      checksum: "44696efbae2d302e4cbf5da60083a0771edb4e97ff7952cc21e89187503606df"),
        
        .testTarget(
            name: "TikiSdkTests",
            dependencies: ["TikiSdk",
                           "App",
                           "flutter_secure_storage",
                           "Flutter",
                           "FlutterPluginRegistrant",
                           "path_provider_ios",
                           "sqlite3_flutter_libs",
                           "sqlite3",
                          ]),
        ]
)
