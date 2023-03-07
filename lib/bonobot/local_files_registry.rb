# frozen_string_literal: true
require "parallel"
require "byebug"

module Bonobot
  class LocalFilesRegistry
    def self.all
      @all ||= Parallel.map(Dir.glob(root.join("**", "*.{erb,rb}"))) do |path|
        LocalFile.new(path, rails_root)
      end
    end

    def self.root
      rails_root.join("app")
    end

    def self.rails_root
      ::Rails.root
    end

    def self.output
      all.map(&:as_json)
    end
  end
end
