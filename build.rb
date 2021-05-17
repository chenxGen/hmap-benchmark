require 'xcodeproj'

$buildsdk=`xcodebuild -showsdks | grep iphonesimulator | awk '{print $NF}'`
$buildsdk.chomp!

module Xcodeproj
  def build
    workspace=Dir.glob('*.xcworkspace').first
    scheme=workspace.split('.').first
    puts '- xcodebuild clean'
    system('xcodebuild clean > /dev/null')
    puts '  - clean derived data cache'
    cache_path=Dir.home + '/Library/Developer/Xcode/DerivedData/'
    Dir.glob(cache_path + scheme + '*').each do |f|
      system("rm -rf #{f}")
    end
    puts '- xcodebuild build'
    t_start = Time.now
    system("xcodebuild -workspace #{workspace} -scheme #{scheme} -configuration Debug -sdk #{$buildsdk} > /dev/null")

    t_end = Time.now
    cost=t_end - t_start
    cost
  end
  module_function :build
end
