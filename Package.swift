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
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.25/App_debug.xcframework.zip",
                      checksum: "4eaa54ba2140b15e51dc59b2789ffcfdf57caed0b58afcfb31c8a317b1574d55"),
                          
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.25/flutter_secure_storage.xcframework.zip",
                      checksum: "c14e5207e3e767c86900ab1426a45116ecd2518009b6029d1c7ec0da4405c4ae"),
        
        .binaryTarget(name: "Flutter",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.25/Flutter.xcframework.zip",
                      checksum: "a80650456a503e25cdd67cd19243da22aa0176e83defcc15e4891b8b0e82a849"),
        
        .binaryTarget(name: "FlutterPluginRegistrant",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.25/FlutterPluginRegistrant.xcframework.zip",
                      checksum: "e74a9779bcd74315320a2dc135f95280aa2ff6d798bc1f9483638ad16e272588"),
        
        .binaryTarget(name: "path_provider_ios",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.25/path_provider_ios.xcframework.zip",
                      checksum: "812e7066aa6dc0f135e1fa4049a5e64cc8258cf8d8afecfe703b9b6392d24656"),
        
        .binaryTarget(name: "sqlite3_flutter_libs",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.25/sqlite3_flutter_libs.xcframework.zip",
                    checksum: "04cf3e6d00d8e6385bd21c96e09ef5c45000e9968b4cf488e91bde2715f3d7d7"),
        
        .binaryTarget(name: "sqlite3",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.25/sqlite3.xcframework.zip",
                      checksum: "521870f1320f096c91b7aa1dcb09e3d04e6bc0f785dcbc8c889e48965fffa257"),
        ]
)
