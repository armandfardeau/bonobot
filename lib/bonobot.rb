# frozen_string_literal: true

require "bonobot/railtie"

module Bonobot
  autoload :Status, "bonobot/status"
  autoload :LocalFilesRegistry, "bonobot/local_files_registry"
  autoload :LocalFile, "bonobot/local_file"
  autoload :EnginesFilesRegistry, "bonobot/engines_files_registry"
  autoload :EngineFile, "bonobot/engine_file"
  autoload :OverloadsRegistry, "bonobot/overloads_registry"
  autoload :Overload, "bonobot/overload"
  autoload :FilesOp, "bonobot/files_op"
  autoload :Annotator, "bonobot/annotator"
  autoload :Configuration, "bonobot/configuration"
  autoload :Findable, "bonobot/findable"
  autoload :Outputable, "bonobot/outputable"
  autoload :Reloadable, "bonobot/reloadable"
end
