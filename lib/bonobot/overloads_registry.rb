# frozen_string_literal: true

module Bonobot
  module OverloadsRegistry
    def self.all
      @all ||= LocalFilesRegistry.all.flat_map do |local_file|
        next if local_file.annotation.nil?

        engines_files = EnginesFilesRegistry.find_by(short_path: local_file.path)
        if engines_files.empty?
          Overload.new(local_file, nil)
        else
          engines_files.map do |engine_file|
            Overload.new(local_file, engine_file)
          end
        end
      end
    end

    # TODO: Extract to module
    def self.find_by(attributes)
      all.select do |item|
        attributes.all? do |key, value|
          item.try(key) == value
        end
      end
    end

    def self.output
      all.map(&:as_json)
    end
  end
end
