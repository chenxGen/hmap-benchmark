require 'xcodeproj'
require 'colored2'

$buildsdk=`xcodebuild -showsdks | grep iphonesimulator | awk '{print $NF}'`
$buildsdk.chomp!

module Xcodeproj
  class BuildTool
    attr_accessor :workspace
    attr_accessor :scheme
    def initialize(workspace, scheme)
      self.workspace = workspace
      self.scheme = scheme
    end
    def clean_cache
      puts '- xcodebuild clean'
      system('xcodebuild clean > /dev/null')
      puts '  - clean derived data cache'
      cache_path=Dir.home + '/Library/Developer/Xcode/DerivedData/'
      Dir.glob(cache_path + scheme + '*').each do |d|
        if File.directory?(d)
          system("rm -rf #{d}")
        else
          File.delete(d)
        end
      end
    end
    def pod_install
      # pod install
      suc=system('arch -x86_64 bundle exec pod install')
      unless suc
        puts '[x] pod install failed.'.red
      end
      suc
    end
    def run
      puts '- xcodebuild build'
      t_start = Time.now.to_f
      #system("xcodebuild -workspace #{workspace} -scheme #{scheme} -configuration Debug -destination 'platform=iOS,id=20b87b696bc99b2c6e6950c76a7fa0cf6cd9f933' > /dev/null")
      system("xcodebuild -workspace #{workspace} -scheme #{scheme} -configuration Debug -sdk #{$buildsdk} -showBuildTimingSummary")
      t_end = Time.now.to_f
      cost=t_end - t_start
      cost
    end
  end
end
