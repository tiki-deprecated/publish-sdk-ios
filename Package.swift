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
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.24/App_debug.xcframework.zip",
//                      //checksum: "b45f94d0a4fec948086ae914dae851691c16e1588205108758821a3714a1e26d"), // release - production
                      checksum: "594d97eee883c446dd3de99e303da815e8da25e10ecbfb064bf595a788f2420b"), // debug - testing
                          
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.24/flutter_secure_storage.xcframework.zip",
                      checksum: "7f771c1f6d941780e4e8513424b94a7e4a1c94314c6d474f71da8ef9677b0a24"),
        
        .binaryTarget(name: "Flutter",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.24/Flutter.xcframework.zip",
                      checksum: "45915c7260d2af9c9b09f0838829bff4b8d79a651300e6222d881d563d3c0f77"),
        
        .binaryTarget(name: "FlutterPluginRegistrant",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.24/FlutterPluginRegistrant.xcframework.zip",
                      checksum: "1306bfec4a6e4e121cfb03e8f6543fec7bf648e0a8ff3c0cfd748ce8af44648d"),
        
        .binaryTarget(name: "path_provider_ios",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.24/path_provider_ios.xcframework.zip",
                      checksum: "92fe94320f52e4fde0f826af6be696fcb8db7db0cc2f6a1d98cac7e8e3363d2a"),
        
        .binaryTarget(name: "sqlite3_flutter_libs",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.24/sqlite3_flutter_libs.xcframework.zip",
                    checksum: "e5ed535f15ec8beb66720a6027941939bbad590d6cc82f373557279f94bc2698"),
        
        .binaryTarget(name: "sqlite3",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.24/sqlite3.xcframework.zip",
                      checksum: "d4ffe596e58e6751283186addaa4a1d2ebfe353e9ef72fc4e678be1d02216eaf"),
        ]
)
