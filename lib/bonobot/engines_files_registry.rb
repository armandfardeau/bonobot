# frozen_string_literal: true

module Bonobot
  class EnginesFilesRegistry
    def self.all
      @all ||= Parallel.flat_map(::Rails::Engine.subclasses) do |klass|
        # TODO: Deduplicate files
        Dir.glob("#{klass.instance.root}/app/**/*.{erb,rb}").map do |path|
          EngineFile.new(path, klass)
        end
      end
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
  end
end
