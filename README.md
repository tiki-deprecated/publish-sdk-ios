
# TIKI SDK (iOS) —Consumer Data Licensing

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->

[![All Contributors](https://img.shields.io/badge/all_contributors-2-orange.svg?style=flat-square)](#contributors-)

<!-- ALL-CONTRIBUTORS-BADGE:END -->

  

The TIKI SDK for iOS makes it easy to add consumer data licensing to your iOS applications. It's the client-side component that your users will interact with to accept (or decline) data licensing offers. TIKI's SDK creates immutable, digitally signed license records using cryptographic hashing, forming an audit trail. Programmatically consume records and enforce terms client or server-side using developer-friendly data structures and [APIs](https://mytiki.com/reference/getting-started).

  

This library includes both configurable pre-built UI flows/elements and native low-level APIs for building custom experiences.

  

**Get started with our 📚 [SDK docs](https://mytiki.com/docs/sdk-overview), or jump right into the 📘 [API reference](https://tiki-sdk-ios.docs.mytiki.com/documentation/tikisdk/).**

## Installing

_Note: Before you get started, you will need a Publishing ID. It's free to create one; simply log in to our 🧑‍💻 [Developer Console](https://console.mytiki.com) and create a new Project._

### Podfile

1. Add TikiSdk dependencies in Podfile:
```
target 'TikiSdkExample'  do

use_frameworks!
  # ... other dependencies
  pod 'TikiSdkDebug', '3.0.0', :configurations => 'Debug'
  pod 'TikiSdkRelease', '3.0.0', :configurations => 'Release'

end
```  
2. Run `pod install`.

That's it. And yes, it's really that easy.

# Contributing  

- Use [GitHub Issues](https://github.com/tiki/tiki-sdk-ios/issues) to report any bugs you find or to request enhancements.

- If you'd like to get in touch with our team or other active contributors, pop in our 👾 [Discord](https://discord.gg/tiki).

- Please use [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) if you intend to add code to this project.


## Project Structure

_This project leverages and bundles the Flutter Engine to create a bidirectional channel between the native interface and the core library._

-  `/TikiSdk`: The primary implementation source for the library.

-  `/Frameworks`: XCFrameworks from [publish-sdk-channel](https://github.com/tiki/publish-sdk-channel).

-  `/TikiSdkTests`: Unit and Integration tests.

-  `/TikiSdkExample`: Simple example app showing how to get started configuring and adding the SDK to a basic iOS app.


## Contributors ✨


Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):


<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->

<!-- prettier-ignore-start -->

<!-- markdownlint-disable -->

<table>

<tbody>

<tr>

<td  align="center"  valign="top"  width="14.28%"><a  href="https://www.linkedin.com/in/ricardolg/"><img  src="https://avatars.githubusercontent.com/u/8357343?v=4?s=100"  width="100px;"  alt="Ricardo Gonçalves"/><br  /><sub><b>Ricardo Gonçalves</b></sub></a><br  /><a  href="https://github.com/tiki/tiki-sdk-ios/commits?author=ricardobrg"  title="Code">💻</a>  <a  href="https://github.com/tiki/tiki-sdk-ios/commits?author=ricardobrg"  title="Documentation">📖</a>  <a  href="#maintenance-ricardobrg"  title="Maintenance">🚧</a></td>

<td  align="center"  valign="top"  width="14.28%"><a  href="http://mytiki.com"><img  src="https://avatars.githubusercontent.com/u/3769672?v=4?s=100"  width="100px;"  alt="Mike Audi"/><br  /><sub><b>Mike Audi</b></sub></a><br  /><a  href="https://github.com/tiki/tiki-sdk-ios/pulls?q=is%3Apr+reviewed-by%3Amike-audi"  title="Reviewed Pull Requests">👀</a></td>

</tr>

</tbody>

</table>

  

<!-- markdownlint-restore -->

<!-- prettier-ignore-end -->

  

<!-- ALL-CONTRIBUTORS-LIST:END -->

  

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!