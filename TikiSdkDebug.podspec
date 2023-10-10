Pod::Spec.new do |s|
  
  s.name             = 'TikiSdkDebug'
  s.version          = '2.1.8'
  s.summary          = 'TIKI SDK (iOS) - Consumer Data Licensing'
  s.description      = 'The TIKI SDK for iOS makes it easy to add consumer data licensing to your iOS applications. It is the client-side component that your users will interact with to accept (or decline) data licensing offers.'
  s.homepage         = 'https://mytiki.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'TIKI Team' => 'hello@mytiki.com' }
  s.platforms        = { :ios => '13.0' }
  s.source           = { :git => 'https://github.com/tiki/publish-sdk-ios.git', :tag => 'fix/add-podspec-debug' }
  s.swift_versions   = '5.8.0'

  s.source_files = 'Sources/**/*.swift'

  s.vendored_frameworks = [
    'Frameworks/Debug/App.xcframework',
    'Frameworks/Debug/Flutter.xcframework',
    'Frameworks/Debug/FlutterPluginRegistrant.xcframework',
    'Frameworks/Debug/flutter_secure_storage.xcframework',
    'Frameworks/Debug/sqlite3_flutter_libs.xcframework',
    'Frameworks/Debug/sqlite3.xcframework'
  ]
end
