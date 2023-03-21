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
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.1/App_debug.xcframework.zip",
                      checksum: "5f3091da5264f4e25d81933db4802396aa22481de921bd6c1ff630be64902ac7"),
        
        .binaryTarget(name: "Flutter",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.1/Flutter_debug.xcframework.zip",
                      checksum: "82ab7da81fc7c44bcad72ee0c67ff0e6814484a9e5151cc76fd5e120168f5f30"),
                          
        .binaryTarget(name: "FlutterPluginRegistrant", 
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.1/FlutterPluginRegistrant.xcframework.zip",
                      checksum: "644cd52640e3a0b6158bf773c495e7526477d6bcfa38caf036a764ee13fde6f0"),
        
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.1/flutter_secure_storage.xcframework.zip",
                      checksum: "395e1eaf96b9d4d4bf0320ec538443fdb42c997c8aa1130899c47f114d42d1a5"),
        
        .binaryTarget(name: "path_provider_foundation",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.1/path_provider_foundation.xcframework.zip",
                      checksum: "3d2d6da980c97fa7f4c2141fc0043f7023c9b00d5b0defb3c4b91cfbf2c53cc7"),
        
        .binaryTarget(name: "sqlite3_flutter_libs",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.1/sqlite3_flutter_libs.xcframework.zip",
                    checksum: "2b992a6d2bbe648ac4d5c2ff7fad9042f460f7c95c7e47305028bb1e9a7bcdf6"),
        
        .binaryTarget(name: "sqlite3",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/2.1.1/sqlite3.xcframework.zip",
                      checksum: "f92976ad326c98ae257417a6d1d026115ef7ddadf6f25f68e716d2dbeb0b2248"),
        ]
)

package.dependencies.append(
    .package(url: "https://github.com/SwiftPackageIndex/SPIManifest.git", from: "0.12.0")
)
