require "byebug"

module Bonobot
  class Overload
    attr_reader :engine_file

    def initialize(local_file, engine_file)
      @local_file = local_file
      @engine_file = engine_file
    end

    def path
      @local_file.path
    end

    def status
      return :missing if @local_file.annotation.nil?
      return :up_to_date if @local_file.annotation == @engine_file.fingerprint

      :out_of_date
    end

    def to_hash
      instance_values.merge({ "status" => status, "path" => path })
    end
  end
end