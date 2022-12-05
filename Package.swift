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
        
        .binaryTarget(name: "path_provider_ios",
//                      url: "https://github.com/tiki/tiki-sdk-ios/raw/main
                      path:"./Frameworks/path_provider_ios.xcframework"),
//                      checksum: "6640afac3b7d622e51e9b886b2dde631f7a57b4f52b3cb0b5115b4eba5e9a899"),

        
        .binaryTarget(name: "sqlite3_flutter_libs",
//                      url: "https://github.com/tiki/tiki-sdk-ios/raw/main
                      path:"./Frameworks/sqlite3_flutter_libs.xcframework"),
//                      checksum: "8b7e6570bc7a507f4d6d1046aa7548302273fd157710fa914d269b5a9d8c557f"),
        .binaryTarget(name: "sqlite3",
//                      url: "https://github.com/tiki/tiki-sdk-ios/raw/main
                      path:"./Frameworks/sqlite3.xcframework"),
//                      checksum: "0e9c7da39d70d62313362199368639920babba5c8c2fd3c8e1547edc305ae7b8"),
        .binaryTarget(name: "flutter_secure_storage",
//                      url: "https://github.com/tiki/tiki-sdk-ios/raw/main
                      path:"./Frameworks/flutter_secure_storage.xcframework"),
//                      checksum: "157ef7a8e1f399ca9a399b383506be834bf70d363f6434f5836a7be4caac1239"),
        .binaryTarget(name: "Flutter",
//                      url: "https://github.com/tiki/tiki-sdk-ios/raw/main
                      path:"./Frameworks/Flutter.xcframework"),
//                      checksum: "90a40afb00cdece7c34f57ba1103cee0711feec3d30d02035c7658376a73a4d7"),
        .binaryTarget(name: "FlutterPluginRegistrant",
//                      url: "https://github.com/tiki/tiki-sdk-ios/raw/main
                      path:"./Frameworks/FlutterPluginRegistrant.xcframework"),
//                      checksum: "9c8d688a1953d85360eb2fce008e559557bdae9244022ce484e93bbc80ed2adb"),
        
        
        .binaryTarget(name: "App",
//                      url: "https://github.com/tiki/tiki-sdk-ios/raw/main
                      path:"./Frameworks/App.xcframework"),
//                      checksum: "e11b47193f61021400ebe86eef6a71b65135a32c30e060da42a26983ed367bfb"),
        
        .testTarget(
            name: "TikiSdkTests",
            dependencies: ["TikiSdk"]),
    ]
)
