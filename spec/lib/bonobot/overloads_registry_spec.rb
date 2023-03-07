# frozen_string_literal: true

require "spec_helper"
require "bonobot/overloads_registry"
require "bonobot/local_files_registry"
require "bonobot/engines_files_registry"
require "bonobot/overload"
require "rails"

describe Bonobot::OverloadsRegistry do
  subject(:registry) { described_class }

  let(:engine_file) { build(:engine_file) }
  let(:local_file) { build(:local_file) }

  before do
    allow(Bonobot::EnginesFilesRegistry).to receive(:all).and_return([engine_file])
    allow(Bonobot::LocalFilesRegistry).to receive(:all).and_return([local_file])
  end

  describe ".all" do
    it "returns a hash" do
      expect(registry.all).to be_a(Array)
      expect(registry.all.first).to be_a(Bonobot::Overload)
    end
  end

  describe ".output" do
    it "returns an array" do
      expect(registry.output).to be_an(Array)
    end
  end

  describe ".find_by" do
    let(:path) { "spec/test_files/example_file.rb" }

    it "returns an array" do
      expect(registry.find_by(path: path)).to be_an(Array)
      expect(registry.find_by(path: path).first).to be_a(Bonobot::Overload)
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
end
