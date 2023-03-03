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
                           "path_provider_foundation",
                           "sqlite3_flutter_libs",
                           "sqlite3",
                          ]),
        
        .binaryTarget(name: "App",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/1.1.3/App.xcframework.zip",
                      checksum: "d1f0e4b73abcbbd417324085b063bb61e743897c1f3e1ce9c639b19b21c6376a"),
        
        .binaryTarget(name: "Flutter",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/1.1.3/Flutter.xcframework.zip",
                      checksum: "b8a7d7f638aaa45b001b2b1bc351a63b90cd18c194d225000f150e2c0184d4d6"),
                          
        .binaryTarget(name: "FlutterPluginRegistrant", 
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/1.1.3/FlutterPluginRegistrant.xcframework.zip",
                      checksum: "d3a4484526ac76d47917bec5a8dde67ddecc101564291468edd0eb9e04441b60"),
        
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/1.1.3/flutter_secure_storage.xcframework.zip",
                      checksum: "9f8e62597c867367ba6ec72c0b6724e777633757ec8b3387a968b125cbb9dd58"),
        
        .binaryTarget(name: "path_provider_foundation",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/1.1.3/path_provider_foundation.xcframework.zip",
                      checksum: "91a9a411a360b25e4fd9e895c448c9608f1e089dda4954e89c63dbeb523f4ba3"),
        
        .binaryTarget(name: "sqlite3_flutter_libs",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/1.1.3/sqlite3_flutter_libs.xcframework.zip",
                    checksum: "f50a75f6ba13c1ad8729c3855d4a888e96a3d2e429d6aea525780dad1da1af5c"),
        
        .binaryTarget(name: "sqlite3",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/1.1.3/sqlite3.xcframework.zip",
                      checksum: "b002e9010dfc8cc5a9dbe15996fdb404f98907432fb8c8a22ce5e4b1131c266e"),
        ]
)

package.dependencies.append(
    .package(url: "https://github.com/SwiftPackageIndex/SPIManifest.git", from: "0.12.0")
)
