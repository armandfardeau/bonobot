# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "bonobot/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name = "bonobot"
  spec.version = Bonobot::VERSION
  spec.authors = ["armandfardeau"]
  spec.email = ["fardeauarmand@gmail.com"]
  spec.homepage = "https://github.com/armandfardeau/bonobo"
  spec.summary = "Summary of Bonobot."
  spec.description = "Description of Bonobot."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "parallel", "~> 1.22.1"
  spec.add_dependency "rails", "~> 6.0"

  spec.add_development_dependency "byebug", "~> 11.1"
  spec.add_development_dependency "factory_bot", "~> 6.2.1"
  spec.add_development_dependency "rspec", "~> 3.12.0"
  spec.add_development_dependency "rubocop", "~> 1.30"
  spec.add_development_dependency "rubocop-faker", "~> 1.1.0"
  spec.add_development_dependency "rubocop-rspec", "~> 2.11.1"
  spec.add_development_dependency "simplecov", "~> 0.21.2"
  spec.add_development_dependency "simplecov-cobertura", "~> 2.1.0"
end
