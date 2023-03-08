# frozen_string_literal: true

require "spec_helper"

describe Bonobot::EnginesFilesRegistry do
  subject(:registry) { described_class }

  let(:engine1) { build(:engine, engine_name: "DummyEngine1") }
  let(:engine2) { build(:engine, engine_name: "DummyEngine2") }
  let(:engine3) { build(:engine, engine_name: "DummyEngine3") }

  before do
    allow(::Rails::Engine).to receive(:subclasses).and_return([engine1, engine2, engine3])
    allow(Bonobot::EnginesFilesRegistry).to receive(:root).and_return(Pathname.new("spec/test_files"))
  end

  describe ".all" do
    it "returns an array" do
      expect(registry.all).to be_an(Array)
      expect(registry.all.first).to be_a(Bonobot::EngineFile)
      expect(registry.all.count).to eq(5)
    end
  end

  describe ".generate" do
    it "returns an array" do
      expect(registry.generate).to be_an(Array)
      expect(registry.generate.first).to be_a(Bonobot::EngineFile)
      expect(registry.generate.count).to eq(15)
    end
  end

  describe ".find_by" do
    let(:path) { "spec/test_files/example_file.rb" }

    it "returns an array" do
      expect(registry.find_by(path: path)).to be_an(Array)
      expect(registry.find_by(path: path).first).to be_a(Bonobot::EngineFile)
      expect(registry.find_by(path: path).count).to eq(1)
    end

    context "when no file is found" do
      let(:path) { "spec/test_files/non_existent_file.rb" }

      it "returns an empty array" do
        expect(registry.find_by(path: path)).to be_an(Array)
        expect(registry.find_by(path: path).count).to eq(0)
      end
    end

    context "when key is not found" do
      it "returns an empty array" do
        expect(registry.find_by(non_existent_key: path)).to be_an(Array)
        expect(registry.find_by(non_existent_key: path).count).to eq(0)
      end
    end
  end

  describe ".output" do
    it "returns an array" do
      expect(registry.output).to be_an(Array)
      expect(registry.output.first).to be_a(Hash)
    end
  end
end
