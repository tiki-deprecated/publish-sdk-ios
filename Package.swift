// swift-tools-version:5.8.0

import PackageDescription

let package = Package(
    name: "TikiSdk",
    platforms: [
            .iOS(.v15)
    ],
    products: [
        .library(
            name: "TikiSdk",
            targets: ["TikiSdk"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftPackageIndex/SPIManifest.git", from: "0.12.0")
    ],
    targets: [
        .target(
            name: "TikiSdk",
            dependencies: [
                           "App",
                           "flutter_secure_storage",
                           "Flutter",
                           "FlutterPluginRegistrant",
                           "sqlite3_flutter_libs",
                           "sqlite3",
                          ],
            resources: [
                .process("Media.xcassets"),
                .process("Resources/learnMore.md")
            ]
        ),
        .binaryTarget(name: "App", path: "./Frameworks/Debug/App.xcframework"),
//                      url: "https://github.com/tiki/tiki-trail-platform-channel/releases/download/2.1.0/App_debug.xcframework.zip",
//                      checksum: "a28b9ac49ef9a9f3fb59cb75553ab2901f5ff997003ee799dd8e29f70ec41733"),
        
        .binaryTarget(name: "Flutter", path: "./Frameworks/Debug/Flutter.xcframework"),
//                      url: "https://github.com/tiki/tiki-trail-platform-channel/releases/download/2.1.0/Flutter_debug.xcframework.zip",
//                      checksum: "998644e57af7dbccb9d147fe0f1cba1a2fca4b048ddca4193420373d7fe5da6e"),
//
        .binaryTarget(name: "FlutterPluginRegistrant", path: "./Frameworks/Debug/FlutterPluginRegistrant.xcframework"),
//                      url: "https://github.com/tiki/tiki-trail-platform-channel/releases/download/2.1.0/FlutterPluginRegistrant.xcframework.zip",
//                      checksum: "470c760715be082a27f4e1ab52101ac9ef2ac97e159a85b1d5d42211286e86ba"),
        
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-trail-platform-channel/releases/download/2.1.0/flutter_secure_storage.xcframework.zip",
                      checksum: "e4cf95fb7fd7ba6595261e9b1c31d7b61c1af226e48f5303b4f583df160fa946"),
        
        .binaryTarget(name: "sqlite3_flutter_libs",
                      url: "https://github.com/tiki/tiki-trail-platform-channel/releases/download/2.1.0/sqlite3_flutter_libs.xcframework.zip",
                      checksum: "f37ace3df1379a0375122f23571519a2711384f7a9e68764581e0c696ed990cf"),
        
        .binaryTarget(name: "sqlite3",
                      url: "https://github.com/tiki/tiki-trail-platform-channel/releases/download/2.1.0/sqlite3.xcframework.zip",
                      checksum: "40a64f5523a643ee750e2a8f0ca6202d759e15fb8ec32680ea57d23895243ef3"),
    ]
)
