# frozen_string_literal: true

module Bonobot
  class Annotator
    def self.add_annotation(path, fingerprint)
      new(path, fingerprint).add_annotation
    end

    def self.update_annotation(path, fingerprint)
      new(path, fingerprint).update_annotation
    end

    def initialize(path, fingerprint)
      @path = path
      @fingerprint = fingerprint
    end

    def add_annotation
      f = File.read(@path).split("\n")

      if f.first == "# frozen_string_literal: true"
        f.insert(1, "\n#{annotation}")
      else
        f.insert(0, "\n#{annotation}")
      end

      File.write(@path, "#{f.join("\n")}\n")
    end

    def update_annotation
      f = File.read(@path).split("\n")

      f.each_with_index do |line, index|
        f[index] = annotation if match_line(line)
      end

      File.write(@path, "#{f.join("\n")}\n")
    end

    def annotation
      if @path.to_s.end_with?(".erb")
        "<%# bonobot_fingerprint: #{@fingerprint} %>"
      else
        "# bonobot_fingerprint: #{@fingerprint}"
      end
    end

    def match_line(line)
      line.include?("# bonobot_fingerprint") || line.include?("<%# bonobot_fingerprint")
    end
  end
end
