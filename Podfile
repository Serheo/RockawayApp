# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RockawayApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

    pod 'Alamofire', '~> 4.5.0'
    pod 'AlamofireImage', '~> 3.3.0’
end

post_install do |installer|
    # Your list of targets here.
    myTargets = ['Alamofire', 'AlamofireImage']
    installer.pods_project.targets.each do |target|
        if myTargets.include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.2'
            end
        end
    end
end
