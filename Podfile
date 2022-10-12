# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

flutter_application_path = '../tiki_sdk_flutter_module'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'tiki_sdk_ios' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for tiki_sdk_ios
  install_all_flutter_pods(flutter_application_path)

  target 'tiki_sdk_iosTests' do
    # Pods for testing
  end
end

post_install do |installer|
  flutter_post_install(installer) if defined?(flutter_post_install)
end
