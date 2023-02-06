// swift-tools-version:5.5.0

import PackageDescription

let package = Package(
    name: "TikiSdk",
    platforms: [
            .iOS(.v13)
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
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/1.0.0/App_debug.xcframework.zip",
                      checksum: "f0a105d79f2f4dd490c329f38ed7aae5e58f7767323ab15a44d03c1d81788b8c"),
        
        .binaryTarget(name: "Flutter",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/1.0.0/Flutter_debug.xcframework.zip",
                      checksum: "3b0b17653ee07b073ea262b55d0af3c897242a8182ae62607d2bd5bd831e523e"),
                          
        .binaryTarget(name: "FlutterPluginRegistrant",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/1.0.0/FlutterPluginRegistrant.xcframework.zip",
                      checksum: "345c6f2aa453eab735f6387ee93c9fb5abc00f31c68cb1da93cb5c7e70ffbc5e"),
        
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/1.0.0/flutter_secure_storage.xcframework.zip",
                      checksum: "a21cf4d03d13d8141d949e3e1509d86197421517a4866bd64a99f9f87574e70c"),
        
        .binaryTarget(name: "path_provider_ios",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/1.0.0/path_provider_ios.xcframework.zip",
                      checksum: "c3f4b8e291ea8d18033d8f4b9fb866dbed964b85be8bb2bb474fb67d9fb00b3a"),
        
        .binaryTarget(name: "sqlite3_flutter_libs",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/1.0.0/sqlite3_flutter_libs.xcframework.zip",
                    checksum: "7cd061d47fa918199c8b625a26e32bc2764cb3caee5fe335b189e7bdf40e41b3"),
        
        .binaryTarget(name: "sqlite3",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/1.0.0/sqlite3.xcframework.zip",
                      checksum: "78366f2a23a504be0b97e54eddda4a768fff0e5cf23798a4c2f2110f89ff3541"),
        ]
)
