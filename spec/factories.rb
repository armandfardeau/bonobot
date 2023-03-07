# frozen_string_literal: true

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
    root { Dir.getwd }
  end
end
