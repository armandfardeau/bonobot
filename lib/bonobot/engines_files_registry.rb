# frozen_string_literal: true

module Bonobot
  class EnginesFilesRegistry
    include Bonobot::Configuration

    def self.all
      @all ||= deduplicate(generate)
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

    def self.find_by(attributes)
      all.select do |local_file|
        attributes.all? do |key, value|
          local_file.try(key) == value
        end
      end
    end

    def self.output
      all.map(&:as_json)
    end

    def self.root(path)
      Pathname.new(path).join(self.configuration.included_dirs)
    end

    def self.file_pattern
      self.configuration.files_pattern
    end
  end
end
