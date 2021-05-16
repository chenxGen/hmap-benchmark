require 'xcodeproj'

module Xcodeproj
  def build
    workspace=Dir.glob('*.xcworkspace').first
    scheme=workspace.split('.').first
    puts '- xcodebuild clean'
    system('xcodebuild clean')
    puts '  - clean derived data cache'
    cache_path=Dir.home + '/Library/Developer/Xcode/DerivedData/'
    Dir.glob(cache_path + scheme + '*').each do |f|
      system("rm -rf #{f}")
    end
    puts '- xcodebuild build'
    t_start = Time.now
    system("xcodebuild -workspace #{workspace} -scheme #{scheme} -configuration Debug -destination 'platform=iOS Simulator,name=iPhone 12,OS=14.5' -quiet >> > /dev/null")
    t_end = Time.now
    cost=t_end - t_start
    puts "+ cost : #{t_end - t_start}s"
    cost
  end
  module_function :build
end
