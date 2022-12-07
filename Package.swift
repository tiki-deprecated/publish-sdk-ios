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
                           "flutter_secure_storage",
                           "Flutter",
                           "FlutterPluginRegistrant",
                           "path_provider_ios",
                           "sqlite3_flutter_libs",
                           "sqlite3",
                          ]),
        
        .binaryTarget(name: "App",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.16%2B2-ios/App.xcframework.zip",
        checksum: "65a6ad3cd05b410f02ea17b778f69c32596296c9e7cd45156b29904598708493"),
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.16%2B2-ios/flutter_secure_storage.xcframework.zip",
                      checksum: "fb1db1c4104cf5a0577f7342479c29db5dc4c2374335e430327535f6e6513668"),
        .binaryTarget(name: "Flutter",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.16%2B2-ios/Flutter.xcframework.zip",
                      checksum: "de1544a0931cf4ae4ff8e519fdb10a2d17866bafcae172e8ca3bc847d3177a9d"),
        .binaryTarget(name: "FlutterPluginRegistrant",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.16%2B2-ios/FlutterPluginRegistrant.xcframework.zip",
                      checksum: "cad07261a21c8302f7a5475cff49a7da30c54db1359376a36e4ea204ec251449"),
        .binaryTarget(name: "path_provider_ios",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.16%2B2-ios/path_provider_ios.xcframework.zip",
                      checksum: "a1cac1bb500c1e4b87037b217825ef7989e2fc943405e9195e7171334870762e"),
        
        .binaryTarget(name: "sqlite3_flutter_libs",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.16%2B2-ios/sqlite3_flutter_libs.xcframework.zip",
                      checksum: "b21e2b84b912bc35cc308ea5c1d2c8a5f739ab0ea07d3a0c7543704a30329235"),
        .binaryTarget(name: "sqlite3",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.16%2B2-ios/sqlite3.xcframework.zip",
                      checksum: "5ddfad96e261bc3283383891d37bc04b8b4177aa651708bc205358b263486a85"),
        

        .testTarget(
            name: "TikiSdkTests",
            dependencies: ["TikiSdk"]),
    ]
)
