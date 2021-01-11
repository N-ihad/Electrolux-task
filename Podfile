# Uncomment the next line to define a global platform for your project
# platform :ios, '10.0'

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
      end
    end
end

target 'Electrolux-task' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Electrolux-task
  pod 'PureLayout'
  pod 'Alamofire'
  pod 'Kingfisher'

end
