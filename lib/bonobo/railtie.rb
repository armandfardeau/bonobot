require "byebug"

module Bonobo
  class Railtie < ::Rails::Railtie
    rake_tasks do
      Dir.glob("#{Gem::Specification.find_by_name("bonobo").gem_dir}/lib/**/*.rake").each { |f| load f }
    end
  end
end
