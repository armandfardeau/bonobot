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

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
          "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0"

  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-faker"
  spec.add_development_dependency "rubocop-rspec"
end
