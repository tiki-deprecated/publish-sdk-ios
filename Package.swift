// swift-tools-version:5.5.0

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
    dependencies: [],
    targets: [
        .target(
            name: "TikiSdk",
            dependencies: [
                           "App",
                           "flutter_secure_storage",
                           "Flutter",
                           "FlutterPluginRegistrant",
                          ],
            resources: [
                .process("Media.xcassets"),
                .process("Resources/learnMore.md")
            ]
        ),
        
        .binaryTarget(name: "App",
                      path: "Frameworks/Debug/App.xcframework"),
//                      url: "https://github.com/tiki/tiki-sdk-platform-channel/releases/download/1.0.8/App.xcframework.zip",
//                      checksum: "b79fce0c511d4f11584e6dad5360548384e99fa37b1ddb07d031b996c3ba8c23"),
        
        .binaryTarget(name: "Flutter",
                      path: "Frameworks/Debug/Flutter.xcframework"),
//                      url: "https://github.com/tiki/tiki-sdk-platform-channel/releases/download/1.0.8/Flutter.xcframework.zip",
//                      checksum: "221a8aa76ed6d6b6857dde129e72d35ebd951d7291a245076b32668661f018d4"),
                          
        .binaryTarget(name: "FlutterPluginRegistrant", 
                      url: "https://github.com/tiki/tiki-sdk-platform-channel/releases/download/1.0.8/FlutterPluginRegistrant.xcframework.zip",
                      checksum: "d498df7e64e0c484f4bcb83c34172e665f270839decdc14e1dad2db4181a694c"),
        
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-sdk-platform-channel/releases/download/1.0.8/flutter_secure_storage.xcframework.zip",
                      checksum: "4bcd062fb8dd741d1da57519e06a2ab86d0eaee5b87f05e96c7bfb4945153457"),
        
        ]
)

package.dependencies.append(
    .package(url: "https://github.com/SwiftPackageIndex/SPIManifest.git", from: "0.12.0")
)
