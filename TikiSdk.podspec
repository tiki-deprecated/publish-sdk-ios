Pod::Spec.new do |s|
  
  s.name             = 'TikiSdk'
  s.version          = '2.1.0'
  s.summary          = 'Summary of TikiSdk'
  s.description      = 'Description of TikiSdk'
  s.homepage         = 'https://mytiki.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'TIKI Team' => 'your@email.com' }
  s.platforms        = { :ios => '13.0' }
  s.source           = { :git => 'https://github.com/tiki/publish-sdk-ios.git', :tag => 'podspec-2.1.0' }
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
