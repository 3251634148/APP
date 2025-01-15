# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'LCX-IOS-APP' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  # 添加 Firebase 核心依赖
  pod 'Firebase/Core'
  pod 'Firebase/Firestore'

  # Pods for LCX-IOS-APP

  target 'LCX-IOS-APPTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'LCX-IOS-APPUITests' do
    # Pods for testing
  end

end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    # 移除重复的 grpc 目标
    if target.name == 'grpc'
      target.build_configurations.each do |config|
        config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
      end
    end
  end
end
