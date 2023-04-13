# TIKI SDK (iOS) —Consumer Data Licensing
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Ftiki%2Ftiki-sdk-ios%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/tiki/tiki-sdk-ios) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Ftiki%2Ftiki-sdk-ios%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/tiki/tiki-sdk-ios)
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-2-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

The TIKI SDK for iOS makes it easy to add consumer data licensing to your iOS applications. It's the client-side component that your users will interact with to accept (or decline) data licensing offers. TIKI's SDK creates immutable, digitally signed license records using cryptographic hashing, forming an audit trail. Programmatically consume records and enforce terms client or server-side using developer-friendly data structures and [APIs](https://mytiki.com/reference/getting-started).

This library includes both configurable pre-built UI flows/elements and native low-level APIs for building custom experiences.

**Get started with our 📚 [SDK docs](https://mytiki.com/docs/sdk-overview), or jump right into the 📘 [API reference](https://tiki-sdk-ios.docs.mytiki.com/documentation/tikisdk/).**

## Installing

_Note: Before you get started, you will need a Publishing ID. It's free to create one; simply log in to our 🧑‍💻 [Developer Console](https://console.mytiki.com) and create a new Project._

Add the Swift Package repository (this repository): `https://github.com/tiki/tiki-sdk-ios`

_If you're unfamiliar with the Swift Package Manager, check out Apple's [instructions](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app)._

- If you're running in debug mode and intend to use the Simulator, you're all set.
- If you're **ready to deploy a release version**, set your package repository to the latest release version. At the time of writing, it's 2.0.3, but make sure to check the [registry](https://swiftpackageindex.com/tiki/tiki-sdk-ios). We release often.

That's it. And yes, it's really that easy.

## Initialization
Initialize the TIKI SDK in minutes with the TIKI pre-built UI and a custom data offer —just 1 builder function ([interactive example](https://mytiki.com/recipes/sdk-pre-built-ui-setup)).

```
try? TikiSdk.config()
    .theme
        .primaryTextColor(Color(red: 0.11, green: 0, blue: 0))
        .secondaryTextColor(Color(red: 0, green: 0, blue: 0).opacity(0.6))
        .primaryBackgroundColor(Color(red: 1, green: 1, blue: 1))
        .secondaryBackgroundColor(Color(red: 0.96, green:0.96, blue:0.96))
        .accentColor(Color(red: 0, green: 0.7, blue: 0.44))
        .fontFamily("SpaceGrotesk")
        .and()
    .offer
        .description("Trade your IDFA (kind of like a serial # for your phone) for a discount.")
        .reward("offerImage")
        .bullet(text: "Learn how our ads perform ", isUsed: true)
        .bullet(text: "Reach you on other platforms", isUsed: false)
        .bullet(text: "Sold to other companies", isUsed: false)
        .terms("terms")
        .ptr("db2fd320-aed0-498e-af19-0be1d9630c63")
        .tag(.deviceId)
        .use(usecases: [LicenseUsecase.attribution])
        .permission(Permission.tracking)
        .add()
    .initialize( publishingId: "<your-publishing-id>", id: "<your-user-id>")
```

Read about styling, selecting metadata, and desiging your offer in our [📚 SDK docs →](https://mytiki.com/docs/sdk-overview).

## UI Flows

The SDK includes 2 pre-built flows: `present()` and `settings()`. Use `present()` to display to the user a new data licensing offer.

```
try TikiSdk.present();
```

Use `settings()` to render a ...settings screen 😲 where users can change their mind and opt-out of an existing license agreement.

```
try TikiSdk.settings();
```

# Contributing

- Use [GitHub Issues](https://github.com/tiki/tiki-sdk-ios/issues) to report any bugs you find or to request enhancements.
- If you'd like to get in touch with our team or other active contributors, pop in our 👾 [Discord](https://discord.gg/tiki).
- Please use [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) if you intend to add code to this project.

## Project Structure
_This project leverages and bundles the Flutter Engine to create a bidirectional  ._

- `/Sources`: The primary implementation source for the library.
    - `/Ui`: Declarative UI flows and elements (SwiftUI)
    - `/Resources` & `/Media.xcassets`: Bundled such as graphics.
    - `/Core` Bi-directional communication with the bundled [tiki-sdk-dart](https://github.com/tiki/tiki-sdk-dart) library using the [Flutter Engine](https://github.com/flutter/engine).
- `/Tests`: Integration tests. Requires a device or simulator, open `Tests.xcodeproj` to run.
- `/TikiSdkExample`: Simple example app showing how to get started configuring and adding the SDK to a basic iOS app.

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://www.linkedin.com/in/ricardolg/"><img src="https://avatars.githubusercontent.com/u/8357343?v=4?s=100" width="100px;" alt="Ricardo Gonçalves"/><br /><sub><b>Ricardo Gonçalves</b></sub></a><br /><a href="https://github.com/tiki/tiki-sdk-ios/commits?author=ricardobrg" title="Code">💻</a> <a href="https://github.com/tiki/tiki-sdk-ios/commits?author=ricardobrg" title="Documentation">📖</a> <a href="#maintenance-ricardobrg" title="Maintenance">🚧</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://mytiki.com"><img src="https://avatars.githubusercontent.com/u/3769672?v=4?s=100" width="100px;" alt="Mike Audi"/><br /><sub><b>Mike Audi</b></sub></a><br /><a href="https://github.com/tiki/tiki-sdk-ios/pulls?q=is%3Apr+reviewed-by%3Amike-audi" title="Reviewed Pull Requests">👀</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
