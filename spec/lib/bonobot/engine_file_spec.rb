# frozen_string_literal: true

require "spec_helper"

describe Bonobot::EngineFile do
  subject(:engine_file) { described_class.new(path, engine) }

  let(:engine) { build(:engine) }
  let(:current_dir) { Dir.getwd }
  let(:path) { "#{current_dir}/spec/test_files/example_file.rb" }

  describe ".new" do
    it "has a path" do
      expect(engine_file.path).to eq(path)
    end

    it "has an engine name" do
      expect(engine_file.engine_name).to eq("dummy")
    end

    context "when engine is a railtie namespace" do
      let(:engine) { build(:engine, :with_railtie_namespace) }

      it "has an engine name" do
        expect(engine_file.engine_name).to eq("dummy/engine")
      end
    end

    it "has a short path" do
      expect(engine_file.short_path).to eq("spec/test_files/example_file.rb")
    end

    it "has a root path" do
      expect(engine_file.root_path).to eq(current_dir)
    end
  end

  describe "#fingerprint" do
    it "has a fingerprint" do
      expect(engine_file.fingerprint).to eq("a0b74d09e2e0c75465ac4e9fca741208")
    end
  end

  describe "#to_hash" do
    it "has a hash" do
      expect(engine_file.to_hash).to match({
                                             "engine_name" => "dummy",
                                             "fingerprint" => "a0b74d09e2e0c75465ac4e9fca741208",
                                             "path" => path,
                                             "short_path" => "spec/test_files/example_file.rb",
                                             "root_path" => current_dir
                                           })
    end
  end
end
