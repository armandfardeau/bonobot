# frozen_string_literal: true

module LocalFiles
  def self.files
    @files ||= Dir.glob(::Rails.root.join("app", "**", "*.{erb,rb}")).map { |path| path.sub("#{::Rails.root}/", "") }.each_with_object({}) do |path, hash|
      hash[path] = read_annotation(path)
    end
  end

  def self.read_annotation(path)
    File.readlines(path).map do |line|
      line.sub(/# bonobot_fingerprint:/, "").sub("<%", "").sub("%>", "").strip if line.match?(/# bonobot_fingerprint:/) || line.match?(/<%# bonobot_fingerprint:/)
    end.compact.first
  end
end
