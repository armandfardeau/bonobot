# frozen_string_literal: true
module Bonobot
  class LocalFilesRegistry
    def self.all
      @all ||= Parallel.map(Dir.glob(root.join("app", "**", "*.{erb,rb}"))) do |path|
        LocalFile.new(path)
      end
    end

    def self.root
      ::Rails.root
    end

    def self.output
      all.map(&:as_json)
    end
  end
end
