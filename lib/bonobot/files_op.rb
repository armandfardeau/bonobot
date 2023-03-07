# frozen_string_literal: true

require "bonobot/overloads_registry"
require "bonobot/annotator"

module Bonobot
  class FilesOp
    def self.missing
      OverloadsRegistry.find_by(status: :missing)
    end

    def self.out_of_date
      OverloadsRegistry.find_by(status: :out_of_date)
    end

    def self.add_missing
      missing.each do |overload|
        Annotator.add_annotation(root.join(overload.path), overload.engine_file.fingerprint)
      end
    end

    def self.update_out_of_date
      out_of_date.each do |overload|
        Annotator.update_annotation(root.join(overload.path), overload.engine_file.fingerprint)
      end
    end

    def self.root
      ::Rails.root
    end
  end
end
