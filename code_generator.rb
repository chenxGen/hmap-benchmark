require "xcodeproj"

module Xcodeproj
  class CodeGenerator
    attr_accessor :target_name
    attr_accessor :pods_to_add
    def initialize(t_name)
      self.target_name=t_name
    end
    def header_code(class_name)
      %{// Made by script
#import <Foundation/Foundation.h>
@interface #{class_name} : NSObject
@end}
    end
    def implementation_code(class_name)
      %{// Made by script
#import "#{class_name}.h"
#{pods_imports.join("\n")}
@implementation #{class_name}
@end}
    end
    def pod_file_code(plugin=True)
      %{# Made by script
# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
warn_for_unused_master_specs_repo => false
#{plugin ? "plugin 'cocoapods-project-hmap'" : ''}

target '#{target_name}' do
  # Comment the next line if you don't want to use dynamic frameworks
  # use_frameworks!

  # Pods for #{target_name}
#{pods_dsl.join("\n")}
  # m1 processor
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      end
    end
  end
end}
    end
    def pods_dsl
      dsls=[]
      pods_to_add.each do |one|
        dsls << "  pod '#{one}'"
      end
      dsls
    end
    def pods_imports
      imports=[]
      pods_to_add.each do |one|
        imports << "#import <#{one}/#{one}.h>"
      end
      imports
    end
  end
end
