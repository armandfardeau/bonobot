# frozen_string_literal: true

module Bonobot
  class LocalFile
    attr_reader :path

    def initialize(path, root)
      @path = path.sub("#{root}/", "")
    end

    def annotation
      File.readlines(@path).map do |line|
        line.sub(/# bonobot_fingerprint:/, "").sub("<%", "").sub("%>", "").strip if line.match?(/# bonobot_fingerprint:/) || line.match?(/<%# bonobot_fingerprint:/)
      end.compact.first.presence
    end
  end
end
