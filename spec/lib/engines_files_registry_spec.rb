require "spec_helper"
require "bonobot/engines_files_registry"

describe Bonobot::EnginesFilesRegistry do
  subject(:registry) { described_class }
  let(:engine) { build(:engine) }

  before do
    allow(::Rails::Engine).to receive(:subclasses).and_return([engine])
    allow(Bonobot::EnginesFilesRegistry).to receive(:root).and_return(Pathname.new("spec/test_files"))
  end

  describe ".all" do
    it "returns an array" do
      expect(registry.all).to be_an(Array)
      expect(registry.all.first).to be_a(Bonobot::EngineFile)
      expect(registry.all.count).to eq(5)
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