source 'https://github.com/CocoaPods/Specs.git'
platform :osx, '10.11'
use_frameworks!

target '12306ForMac' do
    pod 'RealmSwift', '~> 1.1.0'
    pod 'Alamofire', '~> 4.0'
    pod "PromiseKit", "~> 4.0"
    pod 'Fabric'
    pod 'Crashlytics'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
