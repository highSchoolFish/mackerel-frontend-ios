# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'HighSchoolFish' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for HighSchoolFish
  pod 'SwiftyJSON'
  pod 'JWTDecode'
  pod 'BSImagePicker'
  pod 'SideMenu'
  pod 'SafeAreaBrush'
  pod 'Kingfisher'
  pod 'Alamofire'
  pod 'Moya'
  pod 'ImageSlideshow', '~> 1.9.0'
  pod 'Firebase'
  pod 'Firebase/Messaging'
  pod 'Firebase/Analytics'
  pod 'Firebase/InAppMessaging'  
  post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
  end
end

end
