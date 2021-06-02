require "cocoapods"
require "./xcbuild_tool"
require "./print_table"
require './add_files'
require './table_data'

project_root=ARGV.first
if project_root == nil
  puts 'Usage: $ruby run_for_any_project.rb path/to/project_root'
  return
end

project_root=File.expand_path(project_root)
Dir.chdir(project_root)

workspace=Dir.glob('*.xcworkspace').first
scheme=workspace.split('.').first

table_data=HmapBenckmark::TableData.new
build_tool=Xcodeproj::BuildTool.new(workspace, scheme)

$hmap_plugin_enabled = false
HMAP_PLUGIN_NAME = 'cocoapods-project-hmap'

module Pod
  class Installer
    alias old_plugins plugins
    def plugins
      ps = old_plugins
      plugin_added = ps[HMAP_PLUGIN_NAME] != nil
      if $hmap_plugin_enabled != plugin_added
        if $hmap_plugin_enabled
          ps.merge!({ HMAP_PLUGIN_NAME => {}})
        else
          ps.delete(HMAP_PLUGIN_NAME)
        end
      end
      ps
    end
  end
end

build_costs_with_plugin = []
build_costs = []
build_times = 3
build_flags= Array.new(build_times, false) + Array.new(build_times, true)


build_flags.each do |flag|
  $hmap_plugin_enabled = flag
  # pod install
  # exec pod install command with ruby, let the hook above work, without modifying podfile
  unless build_tool.pod_install(false)
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
