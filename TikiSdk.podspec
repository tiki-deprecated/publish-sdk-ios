Pod::Spec.new do |s|
  
  s.name             = 'TikiSdk'
  s.version          = '2.1.0'
  s.summary          = 'Summary of TikiSdk'
  s.description      = 'Description of TikiSdk'
  s.homepage         = 'https://mytiki.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Your Name' => 'your@email.com' }
  s.platforms        = { :ios => '15.0' }
  s.source           = { :git => './', :tag => 'test12' }
  s.swift_versions   = '5.8.0'

  s.source_files = 'Sources/**/*.swift'
  
  s.resource_bundles = {
    'TikiSdk' => ['Sources/TikiSdk/Resources/*.xcassets', 'Resources/learnMore.md']
  }

  s.vendored_frameworks = [
    'Frameworks/Debug/App.xcframework',
    'Frameworks/Debug/Flutter.xcframework',
    'Frameworks/Debug/FlutterPluginRegistrant.xcframework',
    'Frameworks/Debug/flutter_secure_storage.xcframework',
    'Frameworks/Debug/sqlite3_flutter_libs.xcframework',
    'Frameworks/Debug/sqlite3.xcframework'
  ]
end
