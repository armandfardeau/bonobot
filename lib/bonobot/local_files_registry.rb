# frozen_string_literal: true

module Bonobot
  class LocalFilesRegistry
    include Bonobot::Configuration
    include Bonobot::Outputable
    include Bonobot::Reloadable

    def self.all
      @all ||= Parallel.map(Dir.glob(root.join("**", "*.#{file_pattern}"))) do |path|
        LocalFile.new(path, ::Rails.root)
      end
    end

    def self.root
      ::Rails.root.join(configuration.included_dirs)
    end

    def self.file_pattern
      configuration.files_pattern
    end
  end
end
