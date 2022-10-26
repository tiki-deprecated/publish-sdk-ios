flutter_application_path = '../tiki_sdk_flutter/tiki_sdk_flutter'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'tiki_sdk_ios' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  install_all_flutter_pods(flutter_application_path)
  
  target 'tiki_sdk_iosTests' do
    # Pods for testing
  end

end

post_install do |installer|
  flutter_post_install(installer) if defined?(flutter_post_install)
end
