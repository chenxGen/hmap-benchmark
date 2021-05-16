# Made by script
# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'


target 'benchmark' do
  # Comment the next line if you don't want to use dynamic frameworks
  # use_frameworks!

  # Pods for benchmark
  pod 'AFNetworking'
  pod 'SDWebImage'
  pod 'YYModel'
  pod 'YYCache'
  pod 'YYText'
  pod 'YYImage'
  pod 'KSCrash'
  pod 'IGListKit'
  pod 'Masonry'
  pod 'MJExtension'
  # m1 processor
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      end
    end
  end
end