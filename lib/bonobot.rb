# frozen_string_literal: true

require "bonobot/railtie"

module Bonobot
  autoload :Status, "bonobot/status"
  autoload :LocalFiles, "bonobot/local_files"
  autoload :EnginesFiles, "bonobot/engines_files"
  autoload :Overloads, "bonobot/overloads"
end
