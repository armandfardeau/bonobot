# frozen_string_literal: true

module Bonobot
  class Railtie < ::Rails::Railtie
    rake_tasks do
      Dir.glob("#{Gem::Specification.find_by_name("bonobot").gem_dir}/lib/**/*.rake").each { |f| load f }
    end
  end
end
