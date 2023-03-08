# frozen_string_literal: true

module Bonobot::Reloadable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def reload
      @all = nil
    end
  end
end
