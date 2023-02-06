###  [🍍 Console](https://console.mytiki.com) &nbsp; ⏐ &nbsp; [📚 Docs](https://docs.mytiki.com)

# TIKI SDK [iOS] — build the new data economy
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Ftiki%2Ftiki-sdk-ios%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/tiki/tiki-sdk-ios) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Ftiki%2Ftiki-sdk-ios%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/tiki/tiki-sdk-ios)
A Swift Package for adding TIKI's decentralized infrastructure to **iOS** projects. Add tokenized data ownership, consent, and rewards to your app in minutes.

### [🎬 How to get started ➝](https://docs.mytiki.com/docs/tiki-sdk-ios-getting-started)
- **[API Reference ➝](https://docs.mytiki.com/reference/tiki-sdk-ios-tiki-sdk)**
- **[Swift Docs ➝](https://tiki-sdk-ios.docs.mytiki.com)**

#### Basic Architecture
This SDK exposes iOS native (Swift) APIs for the TIKI SDK by:

1. The [tiki-sdk-dart](https://github.com/tiki/tiki-sdk-dart) project is [compiled](https://dart.dev/overview) to platform native machine code.

2. Using the [Flutter Engine](https://github.com/flutter/engine) a bidirectional [MethodChannel](https://api.flutter.dev/flutter/services/MethodChannel-class.html) is created to handle communication between the Android application and the SDK.
