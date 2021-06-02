require "cocoapods"
require "./xcbuild_tool"
require "./print_table"
require './add_files'
require './table_data'

project_root=ARGV.first
if project_root == nil
  puts 'Usage: $ruby run_benchmark.rb path/to/project_root'
  return
end

project_root=File.expand_path(project_root)
Dir.chdir(project_root)

workspace=Dir.glob('*.xcworkspace').first
scheme=workspace.split('.').first

table_data=HmapBenckmark::TableData.new
build_tool=Xcodeproj::BuildTool.new(workspace, scheme)
build_costs=[]
build_costs_with_plugin=[]
test_cases=[[100, 10], [500, 50], [800, 100], [1000, 200]]
#test_cases=[[1000, 200]]
#test_cases=[[1, 200]]
count=0

while count < test_cases.size
  one_case=test_cases[count]
  # add file refers with ARGV
  tool=Xcodeproj::BenckmakrTool.new(one_case.first, one_case.last)
  tool.add_files
  puts "- running case #{count+1}/#{test_cases.size}".green
  current_costs=[]
  current_costs_with_plugin=[]
  build_times = 3
  build_flags= Array.new(build_times, false) + Array.new(build_times, true)
  build_flags.each do |flag|
    tool.gen_podfile(flag)
    # pod install
    unless build_tool.pod_install
      return
    end

    build_tool.clean_cache

    result=build_tool.run
    if result.first == false
      puts 'xcodebuild failed.'
      return
    end

    if flag
      current_costs_with_plugin << result.last
    else
      current_costs << result.last
    end
  end

  build_costs.concat(current_costs)
  build_costs_with_plugin.concat(current_costs_with_plugin)
  table_data.append_data("#{one_case.first} source files & #{[tool.available_pods.size, one_case.last].min} pods", current_costs, current_costs_with_plugin)
  tbl=Print::Table.new(TABLE_LABELS, table_data.datas)
  tbl.print
  count=count+1
end

table_data.append_data('Total', build_costs, build_costs_with_plugin)

tbl=Print::Table.new(TABLE_LABELS, table_data.datas)
tbl.print
