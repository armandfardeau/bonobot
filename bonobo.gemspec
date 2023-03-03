# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "bonobo/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name = "bonobo"
  spec.version = Bonobo::VERSION
  spec.authors = ["armandfardeau"]
  spec.email = ["fardeauarmand@gmail.com"]
  spec.homepage = "https://github/armandfareau/bonobo"
  spec.summary = "Summary of Bonobo."
  spec.description = "Description of Bonobo."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0"

  spec.add_development_dependency "byebug", "~> 11.1"
  spec.add_development_dependency "rubocop", "~> 1.30"
  spec.add_development_dependency "rubocop-faker", "~> 1.1.0"
  spec.add_development_dependency "rubocop-rspec", "~> 2.11.1"
end
