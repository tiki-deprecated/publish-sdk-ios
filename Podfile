platform :ios, '14'

target 'TikiSdkExample' do
  use_frameworks!

  pod 'TikiSdkDebug', :path => './TikiSdkDebug.podspec', :configurations => 'Debug'
  pod 'TikiSdkRelease', :path => './TikiSdkRelease.podspec', :configurations => 'Release'
  
  target 'TikiSdkTests' do
    use_frameworks!
  
    pod 'TikiSdkDebug', :path => './TikiSdkDebug.podspec', :configurations => 'Debug'
    pod 'TikiSdkRelease', :path => './TikiSdkRelease.podspec', :configurations => 'Release'
  
  end
  
end

