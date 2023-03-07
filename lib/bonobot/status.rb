# frozen_string_literal: true

require "json"

module Bonobot
  class Status
    def self.generate
      puts "-----"
      puts "🙈 🙉 🙊 Bonobot 🙈 🙉 🙊"
      puts "-----"
      puts "🛠 Generating status"
      File.write("status.json", status_json)
      puts File.expand_path("status.json")
      puts "-----"

      unless OverloadsRegistry.find_by(status: :up_to_date).empty?
        puts "🥳 Up to date fingerprint count: #{OverloadsRegistry.find_by(status: :up_to_date).count}"
        puts "-> Up to date fingerprint: #{present(OverloadsRegistry.find_by(status: :up_to_date))}"
        puts ""
      end

      unless OverloadsRegistry.find_by(status: :out_of_date).empty?
        puts "😱 Out of date fingerprint count: #{OverloadsRegistry.find_by(status: :out_of_date).count}"
        puts "-> Out of date fingerprint: #{present(OverloadsRegistry.find_by(status: :out_of_date))}"
        puts ""
      end

      unless OverloadsRegistry.find_by(status: :missing).empty?
        puts "🤬 Files missing fingerprint count: #{OverloadsRegistry.find_by(status: :missing).count}"
        puts "-> Missing fingerprint: #{present(OverloadsRegistry.find_by(status: :missing))}"
        puts ""
      end

      puts "-----"
      OverloadsRegistry.find_by(status: :out_of_date).empty? && OverloadsRegistry.find_by(status: :missing).empty?
    end

    def self.present(entries)
      entries = entries.map do |entry|
        "  - #{entry.engine_file.engine_name}: #{entry.engine_file.short_path} (#{entry.engine_file.fingerprint})"
      end.join("\n")

      "\n#{entries}"
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
