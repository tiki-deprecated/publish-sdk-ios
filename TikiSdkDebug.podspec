Pod::Spec.new do |s|
  
  s.name             = 'TikiSdkDebug'
  s.module_name      = 'TikiSdk'
  s.version          = '3.0.0'
  s.summary          = 'TIKI SDK (iOS) - Consumer Data Licensing'
  s.description      = 'The TIKI SDK for iOS makes it easy to add consumer data licensing to your iOS applications. It is the client-side component that your users will interact with to accept (or decline) data licensing offers.'
  s.homepage         = 'https://mytiki.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'TIKI Team' => 'hello@mytiki.com' }
  s.platforms        = { :ios => '13.0' }
  s.source           = { :git => 'https://github.com/tiki/publish-sdk-ios.git', :tag => '3.0.0' }

  s.swift_versions   = '5.8.0'

  s.source_files = 'TikiSdk/**/*.swift'
  
  s.vendored_frameworks = [
    'Frameworks/Debug/App.xcframework',
    'Frameworks/Debug/Flutter.xcframework',
    'Frameworks/Debug/FlutterPluginRegistrant.xcframework',
    'Frameworks/Debug/flutter_secure_storage.xcframework',
    'Frameworks/Debug/sqlite3_flutter_libs.xcframework',
    'Frameworks/Debug/sqlite3.xcframework'
  ]

end
