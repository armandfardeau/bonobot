# frozen_string_literal: true

module Bonobot::Configuration
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end

  class Configuration
    attr_accessor :included_dirs, :files_pattern, :excluded_files, :fingerprint_algorithm, :fingerprint_human_readable

    def initialize
      @status_file_path = config_value_for("status_file_path", Rails.root)
      @status_file_name = "#{config_value_for("status_file_name", "status")}.json"
      @included_dirs = "{#{config_value_for("included_dirs", ["app"]).join(",")}}"
      @files_pattern = "{#{config_value_for("files_pattern", %w(rb erb)).join(",")}}"
      @excluded_files = config_value_for("excluded_files", [])
      @fingerprint_algorithm = config_value_for("fingerprint_algorithm", "md5")
      @fingerprint_human_readable = config_value_for("fingerprint_human_readable", false)
    end

    def status_file
      File.join(@status_file_path, @status_file_name)
    end

    def self.config_file
      @config_file ||= File.exist?(Rails.root.join(".bonobot.yml")) ? YAML.load_file(Rails.root.join(".bonobot.yml")) : {}
    end

    def config_value_for(key, default_value)
      self.class.config_file.fetch(key, default_value)
    end
  end
end
