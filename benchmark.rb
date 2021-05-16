require './add_files.rb'
require './build.rb'
require 'cocoapods'

build_costs=[]
build_costs_with_plugin=[]
test_cases=[[100, 10], [1000, 10], [1000, 50]]
# test_cases=[[100, 10]]
count=0
while count < test_cases.size
  one_case=test_cases[count]
  # add file refers with ARGV
  tool=Xcodeproj::BenckmakrTool.new(one_case.first, one_case.last)
  tool.add_files
  puts "---- case #{count} start ----"
  current_costs=[]
  current_costs_with_plugin=[]
  [false, true, false, true].each do |flag|
    tool.gen_podfile(flag)
    # pod install
    Pod::Command.run(['install', '--verbose'])
    if flag
      current_costs_with_plugin << Xcodeproj.build
    else
      current_costs << Xcodeproj.build
    end
  end
  puts "build costs (origin): [average:#{current_costs.sum/current_costs.size}][detail:#{current_costs}]"
  puts "build costs (plugin): [average:#{current_costs_with_plugin.sum/current_costs_with_plugin.size}][detail:#{current_costs_with_plugin}]"
  puts "---- case #{count} end ----"
  build_costs = build_costs + current_costs
  build_costs_with_plugin = build_costs_with_plugin + current_costs_with_plugin
  count=count+1
end

puts "total build times : #{count}"
puts "build costs (origin): [average:#{build_costs.sum/build_costs.size}][detail:#{build_costs}]"
puts "build costs (plugin): [average:#{build_costs_with_plugin.sum/build_costs_with_plugin.size}][detail:#{build_costs_with_plugin}]"
