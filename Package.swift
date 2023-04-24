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
                          ],
            resources: [
                .process("Media.xcassets"),
                .process("Resources/learnMore.md")
            ]
        ),
        
        .binaryTarget(name: "App",
                      url: "https://github.com/tiki/tiki-sdk-platform-channel/releases/download/1.0.8/App_debug.xcframework.zip",
                      checksum: "15384112b7d71015b9a58057cca66bca4a33dec011bd9b1476afe1bcb32a77ef"),
        
        .binaryTarget(name: "Flutter",
                      url: "https://github.com/tiki/tiki-sdk-platform-channel/releases/download/1.0.8/Flutter_debug.xcframework.zip",
                      checksum: "c1e062bfa6ba0fa097bbecac09ef4417304a3fa972be5f07529c1269d2e1d6f1"),
                          
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
