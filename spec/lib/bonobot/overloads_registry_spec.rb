# frozen_string_literal: true

require "spec_helper"

describe Bonobot::OverloadsRegistry do
  subject(:registry) { described_class }

  let(:engine_path) { "spec/test_files/annoted_example_file.rb" }
  let(:local_path) { "spec/test_files/annoted_example_file.rb" }
  let(:engine_file) { build(:engine_file, path: engine_path) }
  let(:local_file) { build(:local_file, path: local_path) }

  before do
    registry.reload
    allow(Bonobot::EnginesFilesRegistry).to receive(:all).and_return([engine_file])
    allow(Bonobot::LocalFilesRegistry).to receive(:all).and_return([local_file])
  end

  describe ".all" do
    it "returns an Array" do
      expect(registry.all).to be_a(Array)
      expect(registry.all.first).to be_a(Bonobot::Overload)
    end

    context "when there is no matching engine file" do
      let(:local_path) { "spec/test_files/example_file.rb" }

      it "returns an empty array" do
        expect(registry.all).to be_an(Array)
        expect(registry.all.count).to eq(0)
      end
    end

    context "when there are no files" do
      let(:engine_file) { nil }
      let(:local_file) { nil }

      it "returns an empty array" do
        expect(registry.all).to be_an(Array)
        expect(registry.all.count).to eq(0)
      end
    end

    context "when there are no local files" do
      before do
        allow(Bonobot::LocalFilesRegistry).to receive(:all).and_return([])
      end

      it "returns an empty array" do
        expect(registry.all).to be_an(Array)
        expect(registry.all.count).to eq(0)
      end
    end

    context "when there are no engine files" do
      before do
        allow(Bonobot::EnginesFilesRegistry).to receive(:all).and_return([])
      end

      it "returns an array" do
        expect(registry.all).to be_an(Array)
        expect(registry.all.count).to eq(1)
      end
    end
  end

  describe ".output" do
    it "returns an array" do
      expect(registry.output).to be_an(Array)
    end
  end

  describe ".find_by" do
    let(:searched_path) { "spec/test_files/annoted_example_file.rb" }

    it "returns an array" do
      expect(registry.find_by(path: searched_path)).to be_an(Array)
      expect(registry.find_by(path: searched_path).first).to be_a(Bonobot::Overload)
      expect(registry.find_by(path: searched_path).count).to eq(1)
    end

    context "when no file is found" do
      let(:searched_path) { "spec/test_files/non_existent_file.rb" }

      it "returns an empty array" do
        expect(registry.find_by(path: searched_path)).to be_an(Array)
        expect(registry.find_by(path: searched_path).count).to eq(0)
      end
    end

    context "when key is not found" do
      it "returns an empty array" do
        expect(registry.find_by(non_existent_key: searched_path)).to be_an(Array)
        expect(registry.find_by(non_existent_key: searched_path).count).to eq(0)
      end
    end
  end
end
