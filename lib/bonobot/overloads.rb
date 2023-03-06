# frozen_string_literal: true

module Overloads
  def self.files
    @files ||= LocalFiles.files.each_with_object({}) do |(path, fingerprint), hash|
      EnginesFiles.files.keys.each do |engine_name|
        next unless path.include? engine_name

        source_path = EnginesFiles.files[engine_name].fetch(path, nil)
        next unless source_path

        result = [engine_name, source_path.merge(short_path: path)]

        key = status_key(source_path[:fingerprint], fingerprint)
        if hash[key].nil?
          hash[key] = [result]
        else
          hash[key] << result
        end
      end
    end
  end

  def self.status_key(source_fingerprint, target_fingerprint)
    return :up_to_date if source_fingerprint == target_fingerprint
    return :missing if target_fingerprint.nil?

    :out_of_date
  end

  def self.out_of_date
    files.fetch(:out_of_date, [])
  end

  def self.up_to_date
    files.fetch(:up_to_date, [])
  end

  def self.missing
    files.fetch(:missing, [])
  end
end
