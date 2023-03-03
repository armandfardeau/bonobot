require "byebug"
require "json"

module Bonobo
  class Status
    def self.generate
      puts "#####"
      puts "-----"
      puts "Rails status"
      puts "Rails files: #{self.rails_files.join(", ")}"
      puts "-----"
      puts "Engines status"
      puts "Engines count: #{self.engines_files.keys.count}"
      puts "Engines count: #{self.engines_files.keys}"
      puts "Engines_files: #{self.engines_files}"
      puts "-----"
      puts "Overloads status"
      puts "Overloads count: #{self.overloads.count}"
      puts "Overloads: #{self.overloads}"
      puts "-----"
      puts "Generating status.json"
      File.write("status.json", JSON.pretty_generate({ rails_files: self.rails_files, engines_files: self.engines_files, overloads: self.overloads }))
      puts "#####"
    end

    def self.overloads
      self.rails_files.flat_map do |path|
        self.engines_files.keys.map do |engine_name|
          next unless path.include? engine_name

          source_path = self.engines_files[engine_name].fetch(path, nil)
          next unless source_path

          [engine_name, source_path]
        end
      end.compact.to_h
    end

    def self.rails_files
      Dir.glob(Rails.root.join("app", "**", "*.{erb,rb}")).map { |path| path.sub("#{Rails.root}/", "") }
    end

    def self.engines_files
      ::Rails::Engine.subclasses.each_with_object({}) do |klass, hash|
        paths = Dir.glob("#{klass.instance.root}/app/**/*.{erb,rb}")
        next if paths.empty?

        hash[engine_to_gem(klass)] = engine_paths(paths)
      end
    end

    def self.engine_to_gem(engine_class)
      if engine_class.respond_to?(:railtie_namespace) && engine_class.railtie_namespace
        engine_class.railtie_namespace.to_s.split("::").map(&:underscore).join("/")
      else
        engine_class.engine_name.sub("_engine", "")
      end
    end

    def self.engine_paths(paths)
      paths.each_with_object({}) do |path, hash|
        _name, *short_path = path.sub("#{Bundler.rubygems.gem_dir}/gems/", "").split("/")
        hash[short_path.join("/")] = path
      end
    end

    def gems_dir
      Bundler.rubygems.gem_dir
    end
  end
end