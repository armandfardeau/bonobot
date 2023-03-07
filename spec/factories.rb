# frozen_string_literal: true

require "bonobot/engine_file"
require "bonobot/local_file"

FactoryBot.define do
  Engine = Struct.new(:root, :railtie_namespace, :instance, :engine_name)
  EngineInstance = Struct.new(:root)

  factory :engine do
    instance { build(:engine_instance) }
    engine_name { "dummy_engine" }

    trait :with_railtie_namespace do
      railtie_namespace { "Dummy::Engine" }
    end
  end

  factory :engine_instance do
    root { "#{Dir.getwd}" }
  end

  factory :local_file, class: Bonobot::LocalFile do
    path { "spec/test_files/example_file.rb" }

    initialize_with { new(path, Dir.getwd) }
  end

  factory :engine_file, class: Bonobot::EngineFile do
    path { "spec/test_files/example_file.rb" }
    transient { engine { build(:engine) } }

    initialize_with { new(path, engine) }
  end

  factory :overload, class: Bonobot::Overload do
    transient { engine_file { build(:engine_file) } }
    transient { local_file { build(:local_file) } }

    initialize_with { new(local_file, engine_file) }
  end
end
