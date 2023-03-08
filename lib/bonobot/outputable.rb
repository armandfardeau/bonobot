# frozen_string_literal: true

module Bonobot::Outputable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def output
      all.map(&:as_json)
    end
  end
end
