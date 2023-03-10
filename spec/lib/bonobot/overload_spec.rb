# frozen_string_literal: true

require "spec_helper"

describe Bonobot::Overload do
  subject(:overload) { described_class.new(local_file, engine_file) }

  let(:local_path) { "spec/test_files/example_file.rb" }
  let(:local_file) { build(:local_file, path: local_path) }
  let(:engine_file) { build(:engine_file) }

  describe "#status" do
    let(:local_path) { "spec/test_files/out_of_date_example_file.rb" }

    it "returns :missing" do
      expect(overload.status).to eq(:out_of_date)
    end

    context "when the file is missing annotation" do
      let(:local_path) { "spec/test_files/example_file.rb" }

      it "returns :missing" do
        expect(overload.status).to eq(:missing)
      end
    end

    context "when the file is up to date" do
      let(:local_path) { "spec/test_files/up_to_date_example_file.rb" }

      it "returns :out_of_date" do
        expect(overload.status).to eq(:up_to_date)
      end
    end

    context "when the file is unused" do
      let(:engine_file) { nil }

      it "returns :unused" do
        expect(overload.status).to eq(:unused)
      end
    end
  end

  describe "#to_hash" do
    it "returns a hash with the overload data" do
      expect(overload.to_hash).to eq({
                                       "local_file" => local_file,
                                       "engine_file" => engine_file,
                                       "status" => overload.status,
                                       "path" => local_file.path
                                     })
    end
  end

  describe "#path" do
    it "returns the path of the local file" do
      expect(overload.path).to eq(local_file.path)
    end
  end
end
