require './add_files.rb'
require './build.rb'
require 'colored2'

module Print
  class Table
    attr_accessor :datas
    attr_accessor :columns
    def initialize(labels, datas)
      self.datas = datas
      @columns = labels.each_with_object({}) { |(col,label),h|
       h[col] = {
         label: label,
         width: [datas.map { |g| g[col].size }.max, label.size].max }
       }
    end
    def print_header
     puts "| #{ @columns.map { |_,g| g[:label].ljust(g[:width]) }.join(' | ') } |"
    end

    def print_divider
     puts "+-#{ @columns.map { |_,g| "-"*g[:width] }.join("-+-") }-+"
    end

    def print_line(h)
     str = h.keys.map { |k| h[k].ljust(@columns[k][:width]) }.join(" | ")
     puts "| #{str} |"
    end
    def print
      print_divider
      print_header
      print_divider
      @datas.each { |h| print_line(h) }
      print_divider
    end
  end
end

labels={case:'Case', average:'Average(s)', detail:'Detail(s)'}
$datas = []

module Helper
  def append_data(title, costs, costs_with_plugin)
    ave_cost_origin=costs.sum/costs.size
    ave_cost_plugin=costs_with_plugin.sum/costs_with_plugin.size
    $datas << {case:"#{title} (origin)", average:"#{ave_cost_origin}", detail:"#{costs}"}
    $datas << {case:"#{title} (plugin)", average:"#{ave_cost_plugin}", detail:"#{costs_with_plugin}"}
    speed=(1.0/ave_cost_plugin - 1.0/ave_cost_origin)/(1.0/ave_cost_origin)
    time_saved_rate=(ave_cost_origin - ave_cost_plugin)/ave_cost_origin
    $datas << {case:"> optimization (speed)", average:"#{speed*100.round(2)}%", detail:""}
    $datas << {case:"> optimization (time cost)", average:"#{time_saved_rate*100.round(2)}%", detail:""}
  end
  module_function :append_data
end

Dir.chdir(Dir.pwd + '/app')
build_costs=[]
build_costs_with_plugin=[]
test_cases=[[100, 10], [500, 20], [500, 50], [800, 50]]
# test_cases=[[1, 300]]
count=0
while count < test_cases.size
  one_case=test_cases[count]
  # add file refers with ARGV
  tool=Xcodeproj::BenckmakrTool.new(one_case.first, one_case.last)
  tool.add_files
  puts "- running case #{count+1}/#{test_cases.size}".green
  current_costs=[]
  current_costs_with_plugin=[]
  [false, true, false, true].each do |flag|
    tool.gen_podfile(flag)
    # pod install
    suc=system('arch -x86_64 pod install')
    unless suc
      puts '[x] pod install failed.'.red
      if build_costs.size > 0
        Helper.append_data('Total', build_costs, build_costs_with_plugin)
        tbl=Print::Table.new(labels, $datas)
        tbl.print
      end
      return
    end
    if flag
      puts "- prepare to build project using hmap plugin"
      current_costs_with_plugin << Xcodeproj.build
    else
      puts "- prepare to build project without plugin"
      current_costs << Xcodeproj.build
    end
  end

  build_costs = build_costs + current_costs
  build_costs_with_plugin = build_costs_with_plugin + current_costs_with_plugin
  Helper.append_data("#{one_case.first} source files & #{one_case.last} pods(origin)", current_costs, current_costs_with_plugin)
  count=count+1
end

Helper.append_data('Total', build_costs, build_costs_with_plugin)

tbl=Print::Table.new(labels, $datas)
tbl.print
