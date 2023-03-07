# frozen_string_literal: true

require "json"

module Bonobot
  class Status
    STATUS = { up_to_date: "🥳", out_of_date: "😱", missing: "🤬" }.freeze

    def self.generate(status = nil)
      puts "-----"
      puts "🙈 🙉 🙊 Bonobot 🙈 🙉 🙊"
      puts "-----"
      puts "🛠 Generating status"
      File.write("status.json", status_json)
      puts File.expand_path("status.json")
      puts "-----"

      if status
        generate_status(status.to_sym, STATUS[status.to_sym])
      else
        STATUS.each do |status, emoji|
          generate_status(status, emoji)
        end
      end

      puts "-----"
      OverloadsRegistry.find_by(status: :out_of_date).empty? && OverloadsRegistry.find_by(status: :missing).empty?
    end

    def self.present(entries)
      entries.map do |entry|
        "  - #{entry.engine_file.engine_name}: #{entry.engine_file.short_path} (#{entry.engine_file.fingerprint})"
      end.join("\n")
    end

    def self.generate_status(status, emoji)
      return if OverloadsRegistry.find_by(status: status).empty?

      overload_status = OverloadsRegistry.find_by(status: status)
      status_to_text = status.to_s.capitalize.gsub("_", " ")

      puts "-> #{emoji} #{status_to_text} fingerprint (#{overload_status.count}):"
      puts present(OverloadsRegistry.find_by(status: status))
      puts ""
    end

    def self.status_json
      JSON.pretty_generate({
                             rails_files: LocalFilesRegistry.output,
                             engines_files: EnginesFilesRegistry.output,
                             overloads: OverloadsRegistry.output
                           })
    end
  end
end
