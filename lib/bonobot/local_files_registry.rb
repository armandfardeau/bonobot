# frozen_string_literal: true

require "parallel"

module Bonobot
  class LocalFilesRegistry
    include Bonobot::Configuration

    def self.all
      @all ||= Parallel.map(Dir.glob(root.join("**", "*.#{file_pattern}"))) do |path|
        LocalFile.new(path, rails_root)
      end
    end

    def self.root
      rails_root.join(self.configuration.included_dirs)
    end

    def self.file_pattern
      self.configuration.files_pattern
    end

    def self.rails_root
      ::Rails.root
    end

    def self.output
      all.map(&:as_json)
    end
  end
end
