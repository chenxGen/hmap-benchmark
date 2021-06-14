require "cocoapods"
require "./xcbuild_tool"
require "./print_table"
require './add_files'
require './table_data'

# Usage: ruby run_benckmark.rb --cases='[[1, 200], [20, 200]]' --build-times=3
argv=CLAide::ARGV.new(ARGV)
test_cases = argv.option('project')
build_times = argv.option('build-times', '3').to_i

if project == nil
  puts 'Usage: ruby run_for_any_project.rb --project=path/to/project/root --build-times=3'
  return 1
end

project_root=File.expand_path(project_root)
Dir.chdir(project_root)

workspace=Dir.glob('*.xcworkspace').first
scheme=workspace.split('.').first
use_bundler=Dir.glob('Gemfile').size > 0
podfile=Dir.glob('Podfile').first
if podfile == nil
  puts "Podfile not found at #{project_root}".red
  return 1
end

if use_bundler
  `bundle install`
end

HMAP_PLUGIN_NAME = 'cocoapods-project-hmap'
class PodfileModifier
  def initialize(podfile)
    @podfile = podfile
    read
  end
  def read
    @content = File.read(@podfile)
    @content.gsub!(/plugin[ ]+['|"]#{HMAP_PLUGIN_NAME}['|"]/, '')
    @content.chomp!
  end
  def set_hmap_plugin_on(on=true)
    if on
      content = "#{@content} \nplugin '#{HMAP_PLUGIN_NAME}'"
      File.open(@podfile, 'w') { |f| f << content}
    else
      File.open(@podfile, 'w') { |f| f << @content}
    end
  end
end

modifier=PodfileModifier.new(podfile)

table_data=HmapBenckmark::TableData.new
build_tool=Xcodeproj::BuildTool.new(workspace, scheme)
build_costs_with_plugin = []
build_costs = []
build_flags= Array.new(build_times, false) + Array.new(build_times, true)

build_flags.each do |flag|
  modifier.set_hmap_plugin_on(flag)
  # pod install
  unless build_tool.pod_install(use_bundler)
    return
  end

  build_tool.clean_cache

  # eval pre build script
  pre_build_script = Dir.glob('pre_build.rb').first
  if pre_build_script
    pre_build_script = File.expand_path(pre_build_script)
    eval(File.read(pre_build_script))
  end

  result=build_tool.run
  if result.first == false
    puts 'xcodebuild failed.'
    return
  end

  if flag
    build_costs_with_plugin << result.last
  else
    build_costs << result.last
  end
end

table_data.append_data('Total', build_costs, build_costs_with_plugin)
tbl=Print::Table.new(TABLE_LABELS, table_data.datas)
tbl.print
