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
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.26/App.xcframework.zip",
                      checksum: "a1d26151616ebb99ed49ff7aaab6e49f7935b5efe75a5aecdef8eae60f2359fb"),
                          
        .binaryTarget(name: "flutter_secure_storage",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.26/flutter_secure_storage.xcframework.zip",
                      checksum: "ac4bd2c04c95ecb44d49bf6aee544b6c8da9db8f6981161956f730eccb19c618"),
        
        .binaryTarget(name: "Flutter",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.26/Flutter.xcframework.zip",
                      checksum: "2afb6743c715f1b50068df048857f39fa8fea04455a5b85603e751d9e4bbf556"),
        
        .binaryTarget(name: "FlutterPluginRegistrant",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.26/FlutterPluginRegistrant.xcframework.zip",
                      checksum: "2c17128dffd7feea9fd14af513b3f0ccfb2ff413e1217fed04415a6ae50bd71b"),
        
        .binaryTarget(name: "path_provider_ios",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.26/path_provider_ios.xcframework.zip",
                      checksum: "c472020b0443409c2df9a331dc9010dc5c36629168eb0e96764ff6d5601a02f1"),
        
        .binaryTarget(name: "sqlite3_flutter_libs",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.26/sqlite3_flutter_libs.xcframework.zip",
                    checksum: "b86286e9a109f10a1080cd37be3fba59cd6b4907860c155d1a436f9a120dd86b"),
        
        .binaryTarget(name: "sqlite3",
                      url: "https://github.com/tiki/tiki-sdk-flutter/releases/download/0.0.26/sqlite3.xcframework.zip",
                      checksum: "665c00039aa520e6c5022aae24e45aa05e36e588860f54c056c758e239adecb2"),
        ]
)
