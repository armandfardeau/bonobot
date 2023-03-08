# frozen_string_literal: true

module Bonobot::Findable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def find_by(attributes)
      all.select do |local_file|
        attributes.all? do |key, value|
          local_file.try(key) == value
        end
      end
    end
  end
end
