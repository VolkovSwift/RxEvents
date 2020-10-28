platform :ios, '11.0'
inhibit_all_warnings!
use_frameworks!


def shared_pods
  pod 'RxSwift'
  pod 'RxCocoa'
end

target 'RxEvents' do
  shared_pods
end  
  
target 'RxEventsTests' do
  shared_pods
  inherit! :complete
  pod 'RxTest'
  pod 'RxBlocking'
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
end
