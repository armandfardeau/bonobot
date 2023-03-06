# frozen_string_literal: true

begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

require "rdoc/task"
require "rspec/core/rake_task"

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = "rdoc"
  rdoc.title = "Bonobot"
  rdoc.options << "--line-numbers"
  rdoc.rdoc_files.include("README.md")
  rdoc.rdoc_files.include("lib/**/*.rb")
end

require "bundler/gem_tasks"

require "rake/testtask"

Rake::TestTask.new(:test) do |_t|
  RSpec::Core::RakeTask.new(:spec)
end

task default: :test
