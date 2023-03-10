# frozen_string_literal: true

require "rails"
require "bonobot"
require "simplecov"
require "simplecov-cobertura"
require "factory_bot"
require "parallel"
require "byebug"

SimpleCov.start

SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter if ENV["CODECOV"]

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.before do
    allow(Rails).to receive(:root).and_return(Pathname.new(Dir.getwd))
  end
end
