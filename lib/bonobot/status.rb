# frozen_string_literal: true

require "json"

module Bonobot
  class Status
    def self.generate
      puts "-----"
      puts "🙈 🙉 🙊 Bonobot 🙈 🙉 🙊"
      puts "-----"
      puts "🛠 Generating status"
      File.write("status.json", JSON.pretty_generate({ rails_files: LocalFiles.files, engines_files: EnginesFiles.files, overloads: Overloads.files }))
      puts File.expand_path("status.json")
      puts "-----"

      unless Overloads.status(:up_to_date).empty?
        puts "🥳 Up to date fingerprint count: #{Overloads.status(:up_to_date).count}"
        puts "-> Up to date fingerprint: #{present(Overloads.status(:up_to_date))}"
        puts ""
      end

      unless Overloads.status(:out_of_date).empty?
        puts "😱 Out of date fingerprint count: #{Overloads.status(:out_of_date).count}"
        puts "-> Out of date fingerprint: #{present(Overloads.status(:out_of_date))}"
        puts ""
      end

      unless Overloads.status(:missing).empty?
        puts "🤬 Files missing fingerprint count: #{Overloads.status(:missing).count}"
        puts "-> Missing fingerprint: #{present(Overloads.status(:missing))}"
        puts ""
      end

      puts "-----"
      Overloads.status(:out_of_date).empty? && Overloads.status(:missing).empty?
    end

    def self.present(entry)
      entries = entry.map do |(engine_name, source_path)|
        "  - #{engine_name}: #{source_path[:short_path]} (#{source_path[:fingerprint]})"
      end.join("\n")

      "\n#{entries}"
    end
  end
end
