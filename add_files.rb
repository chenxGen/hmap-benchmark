require 'xcodeproj'
require './code_generator.rb'

module Xcodeproj
  class BenckmakrTool
    TEST_OBJECT_PREFIX = 'TestObject'
    attr_accessor :xcodeproj
    attr_accessor :target
    attr_accessor :code_generator
    attr_accessor :number_of_files_to_add
    attr_accessor :number_of_pods_to_add
    attr_accessor :available_pods

    def initialize(f_num, pod_num)
      self.number_of_files_to_add = f_num
      self.number_of_pods_to_add = pod_num
      open_project
      checking_available_pods
    end

    def add_files
      source_build_phase=target.build_phases.grep(Project::Object::PBXSourcesBuildPhase)[0]
      project_path=target.project.path.dirname.to_s
      puts "- checking if classes group(directory) exsit"
      class_dir=File::join(project_path, target.name, 'classes')
      unless File.directory?(class_dir)
        Dir::mkdir(class_dir)
      end

      dirname=Pathname.new(class_dir).basename
      code_group=xcodeproj.groups[0]
      obj_group=nil
      code_group.groups.each do |g|
        if g.path == 'classes'
          obj_group=g
          break
        end
      end

      unless obj_group
        puts '- create classes group'
        obj_group=code_group.new_group("classes", class_dir)
      else
        puts '- clean classes group'
        obj_group.files.each do |f|
          source_build_phase.remove_file_reference(f)
          path=File.join(class_dir,f.path)
          if File.exist?(path)
              File.delete(path)
          end
        end
        obj_group.clear
      end

      gen_podfile(false)

      puts "- will add #{code_generator.pods_to_add.size} pod header import in each added file"
      puts "- prepare to add #{number_of_files_to_add} file refers to target #{target.name}"

      count=0
      while count < number_of_files_to_add do
        name="#{TEST_OBJECT_PREFIX}#{count}"
        header_path = File::join(class_dir, "/#{name}.h")
        imp_path = File::join(class_dir, "/#{name}.m")
        File::open(header_path, 'w') { |file| file << code_generator.header_code(name) }
        File::open(imp_path, 'w') { |file| file << code_generator.implementation_code(name) }
        obj_group.new_reference(header_path)
        imp_frf=obj_group.new_reference(imp_path)
        source_build_phase.add_file_reference(imp_frf)
        count=count+1
      end
      puts '- finished add files, save project'
      xcodeproj.save
    end

    def gen_podfile(use_plugin=false)
      puts "- add #{code_generator.pods_to_add.size} pod to podfile"
      project_path=target.project.path.dirname.to_s
      podfile=File::join(project_path, 'Podfile')
      File::open(podfile, 'w') {|file| file << code_generator.pod_file_code(use_plugin)}
    end
    private
    def open_project
      projects = Dir.glob('*.xcodeproj')
      if projects.size == 1
        project = projects.first
      elsif projects.size > 1
        raise Informative, 'There are more than one Xcode project documents ' \
                           'in the current working directory.'
      else
        raise Informative, 'No Xcode project document found in the current ' \
                           'working directory.'
      end
      xcodeproj_path = Pathname.new(project).expand_path
      @xcodeproj=Project.open(xcodeproj_path)
      @target=@xcodeproj.objects.grep(Project::Object::PBXNativeTarget)[0]
    end
    def checking_available_pods
      available_pods_path=Dir.pwd + "/../available_pods.rb"
      puts '- checking available pods'
      if File.exists?(available_pods_path)
        require available_pods_path
        self.available_pods = AVAILABLE_PODS
      else
        puts '- available pods not found'
        puts available_pods_path
      end
    end
    def code_generator
      unless @code_generator
        pods_count=[number_of_pods_to_add, available_pods.length].min
        pods=available_pods[0, pods_count]
        @code_generator=CodeGenerator.new(target.name)
        @code_generator.pods_to_add=pods
      end
      @code_generator
    end
  end
end
