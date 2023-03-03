# frozen_string_literal: true

require "json"

module Bonobot
  class Status
    def self.generate
      puts "#####"
      puts "🙈 🙉 🙊 Bonobot 🙈 🙉 🙊"
      puts "-----"
      puts "🛠 Generating status.json"
      File.write("status.json", JSON.pretty_generate({ rails_files: rails_files, engines_files: engines_files, overloads: overloads }))
      puts File.expand_path("status.json")
      puts "-----"

      unless up_to_date.empty?
        puts "🥳 Up to date fingerprint count: #{up_to_date.count}"
        puts "-> Up to date fingerprint: #{up_to_date}"
        puts ""
      end

      unless out_of_date.empty?
        puts "😱 Out of date fingerprint count: #{out_of_date.count}"
        puts "-> Out of date fingerprint: #{out_of_date}"
        puts ""
      end

      unless missing.empty?
        puts "🤬 Files missing fingerprint count: #{missing.count}"
        puts "-> Missing fingerprint: #{missing}"
        puts ""
      end

      puts "-----"
      puts "#####"

      out_of_date.empty? && missing.empty?
    end

    def self.out_of_date
      overloads.fetch(:out_of_date, [])
    end

    def self.up_to_date
      overloads.fetch(:up_to_date, [])
    end

    def self.missing
      overloads.fetch(:missing, [])
    end

    def self.overloads
      @overloads ||= rails_files.each_with_object({}) do |(path, fingerprint), hash|
        engines_files.keys.each do |engine_name|
          next unless path.include? engine_name

          source_path = engines_files[engine_name].fetch(path, nil)
          next unless source_path

          result = [engine_name, source_path]

          key = status_key(source_path[:fingerprint], fingerprint)
          if hash[key].nil?
            hash[key] = [result]
          else
            hash[key] << result
          end
        end
      end
    end

    def self.rails_files
      @rails_files ||= Dir.glob(Rails.root.join("app", "**", "*.{erb,rb}")).map { |path| path.sub("#{Rails.root}/", "") }.each_with_object({}) do |path, hash|
        hash[path] = read_annotation(path)
      end
    end

    def self.engines_files
      @engine_files ||= ::Rails::Engine.subclasses.each_with_object({}) do |klass, hash|
        paths = Dir.glob("#{klass.instance.root}/app/**/*.{erb,rb}")
        next if paths.empty?

        hash[engine_to_gem(klass)] = engine_paths(paths)
      end
    end

    def self.engine_to_gem(engine_class)
      if engine_class.respond_to?(:railtie_namespace) && engine_class.railtie_namespace
        engine_class.railtie_namespace.to_s.split("::").map(&:underscore).join("/")
      else
        engine_class.engine_name.sub("_engine", "")
      end
    end

    def self.engine_paths(paths)
      paths.each_with_object({}) do |path, hash|
        _name, *short_path = path.sub("#{gems_dir}/gems/", "").split("/")
        hash[short_path.join("/")] = { path: path, fingerprint: fingerprint(path) }
      end
    end

    def self.fingerprint(path)
      Digest::MD5.hexdigest(File.read(path))
    end

    def self.gems_dir
      @gems_dir ||= Bundler.rubygems.gem_dir
    end

    def self.read_annotation(path)
      File.readlines(path).map do |line|
        line.sub(/# bonobo_fingerprint:/, "").sub("<%", "").sub("%>", "").strip if line.match?(/# bonobot_fingerprint:/) || line.match?(/<%# bonobot_fingerprint:/)
      end.compact.first
    end

    def self.status_key(source_fingerprint, target_fingerprint)
      return :up_to_date if source_fingerprint == target_fingerprint
      return :missing if target_fingerprint.nil?

      :out_of_date
    end
  end
end
