# frozen_string_literal: true

require "json"

module Bonobot
  class Status
    STATUS = { up_to_date: "🥳", out_of_date: "😱", unused: "😅", missing: "🤬" }.freeze

    def self.generate(status = nil)
      new(status).generate
    end

    def initialize(status)
      @status = status
    end

    def generate
      generate_status_file
      puts display_banner
      return_status_code
    end

    def present(entries)
      entries.map do |entry|
        if entry.engine_file.nil?
          "  - #{entry.path} (unused)"
        else
          "  - #{entry.engine_file.engine_name}: #{entry.engine_file.short_path} (#{entry.engine_file.fingerprint})"
        end
      end.join("\n")
    end

    def generate_status(status, emoji)
      return if OverloadsRegistry.find_by(status: status).empty?

      overload_status = OverloadsRegistry.find_by(status: status)
      status_to_text = status.to_s.capitalize.gsub("_", " ")

      ["-> #{emoji} #{status_to_text} fingerprint (#{overload_status.count}):", present(OverloadsRegistry.find_by(status: status))]
    end

    def status_json
      JSON.pretty_generate({
                             rails_files: LocalFilesRegistry.output,
                             engines_files: EnginesFilesRegistry.output,
                             overloads: OverloadsRegistry.output
                           })
    end

    def generate_status_file
      File.write("status.json", status_json)
    end

    def display_banner
      [display_intro + display_status + display_outro].join("\n")
    end

    def display_intro
      "-----\n🙈 🙉 🙊 Bonobot 🙈 🙉 🙊\n-----\n\n🛠 Generating status\n#{File.expand_path("status.json")}\n-----\n\n"
    end

    def display_status
      if @status
        generate_status(@status.to_sym, STATUS[@status.to_sym])
      else
        STATUS.map do |status_type, emoji|
          generate_status(status_type, emoji)
        end.join("\n")
      end
    end

    def display_outro
      "\n-----"
    end

    def return_status_code
      OverloadsRegistry.find_by(status: :out_of_date).empty? && OverloadsRegistry.find_by(status: :missing).empty?
    end
  end
end
