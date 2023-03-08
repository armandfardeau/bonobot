# frozen_string_literal: true

module Bonobot
  class EnginesFilesRegistry
    include Bonobot::Configuration
    include Bonobot::Findable
    include Bonobot::Outputable
    include Bonobot::Reloadable

    def self.all
      @all ||= deduplicate(generate).reject { |engine_file| configuration.excluded_files.include?(engine_file.short_path) }
    end

    def self.generate
      Parallel.flat_map(::Rails::Engine.subclasses) do |klass|
        Dir.glob(root(klass.instance.root).join("**", "*.#{file_pattern}")).map do |path|
          EngineFile.new(path, klass)
        end
      end
    end

    def self.deduplicate(engine_files)
      engine_files.group_by(&:path).map { |_, files| files.min_by(&:engine_name) }
    end

    def self.root(path)
      Pathname.new(path).join(configuration.included_dirs)
    end

    def self.file_pattern
      configuration.files_pattern
    end
  end
end
