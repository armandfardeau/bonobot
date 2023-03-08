# frozen_string_literal: true

module Bonobot
  module OverloadsRegistry
    include Bonobot::Findable
    include Bonobot::Outputable
    include Bonobot::Reloadable

    def self.all
      @all ||= LocalFilesRegistry.all.flat_map do |local_file|
        next if local_file.nil?

        engines_files = EnginesFilesRegistry.find_by(short_path: local_file.path)

        if engines_files.empty? && local_file.annotation.present?
          Overload.new(local_file, nil)
        else
          engines_files.map do |engine_file|
            Overload.new(local_file, engine_file)
          end
        end
      end.compact
    end
  end
end
