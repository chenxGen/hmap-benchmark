require './add_files.rb'
require './xcbuild_tool.rb'
require './print_table.rb'

$labels={case:'Case', average:'Average(s)', detail:'Detail(s)'}
$datas = []

module Helper
  def append_data(title, costs, costs_with_plugin)
    ave_cost_origin=costs.sum/costs.size
    ave_cost_plugin=costs_with_plugin.sum/costs_with_plugin.size
    $datas << {case:"#{title} (origin)", average:"#{ave_cost_origin}", detail:"#{costs}"}
    $datas << {case:"#{title} (plugin)", average:"#{ave_cost_plugin}", detail:"#{costs_with_plugin}"}
    speed=(1.0/ave_cost_plugin - 1.0/ave_cost_origin)/(1.0/ave_cost_origin)
    time_saved_rate=(ave_cost_origin - ave_cost_plugin)/ave_cost_origin
    $datas << {case:"> optimization (speed)", average:"#{(speed*100).round(2)}%", detail:""}
    $datas << {case:"> optimization (time cost)", average:"#{(time_saved_rate*100).round(2)}%", detail:""}
  end
  module_function :append_data
end

Dir.chdir(Dir.pwd + '/app')
build_costs=[]
build_costs_with_plugin=[]
test_cases=[[100, 10], [500, 50], [800, 100], [1000, 200]]
#test_cases=[[1000, 200]]
#test_cases=[[1, 200]]
count=0

workspace=Dir.glob('*.xcworkspace').first
scheme=workspace.split('.').first
build_tool=Xcodeproj::BuildTool.new(workspace, scheme)

while count < test_cases.size
  one_case=test_cases[count]
  # add file refers with ARGV
  tool=Xcodeproj::BenckmakrTool.new(one_case.first, one_case.last)
  tool.add_files
  puts "- running case #{count+1}/#{test_cases.size}".green
  current_costs=[]
  current_costs_with_plugin=[]

  [false, true].each do |flag|
    tool.gen_podfile(flag)
    # pod install
    suc=build_tool.pod_install
    unless suc
      if build_costs.size > 0
        Helper.append_data('Total', build_costs, build_costs_with_plugin)
        tbl=Print::Table.new($labels, $datas)
        tbl.print
      end
      return
    end

    build_tool.clean_cache

    if flag
      puts "- prepare to build project using hmap plugin"
      current_costs_with_plugin << build_tool.run
    else
      puts "- prepare to build project without plugin"
      current_costs << build_tool.run
    end
  end

  build_costs = build_costs + current_costs
  build_costs_with_plugin = build_costs_with_plugin + current_costs_with_plugin
  Helper.append_data("#{one_case.first} source files & #{[tool.available_pods.size, one_case.last].min} pods", current_costs, current_costs_with_plugin)
  tbl=Print::Table.new($labels, $datas)
  tbl.print
  count=count+1
end

Helper.append_data('Total', build_costs, build_costs_with_plugin)

tbl=Print::Table.new($labels, $datas)
tbl.print
