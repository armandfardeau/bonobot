# frozen_string_literal: true

require "spec_helper"

describe Bonobot::Status do
  subject(:status) { described_class.new(status_key) }

  let(:status_key) { nil }
  let(:status_file) { "spec/status.json" }

  before do
    allow(Bonobot::Status.configuration).to receive(:status_file).and_return(status_file)
  end

  after do
    FileUtils.rm status_file if File.exist?(status_file)
  end

  describe "#display_intro" do
    it "returns a string" do
      expect(subject.display_intro).to be_a(String)
    end
  end

  describe "#display_status" do
    it "returns a string" do
      expect(subject.display_status).to be_a(Array)
      expect(subject.display_status.count).to eq(Bonobot::Status::STATUS.count)
    end

    context "when status_key is used" do
      let(:status_key) { :up_to_date }

      it "returns a string" do
        expect(subject.display_status).to be_a(Array)
        expect(subject.display_status.count).to eq(1)
      end
    end
  end

  describe "#display_outro" do
    it "returns a string" do
      expect(subject.display_outro).to be_a(String)
    end
  end

  describe "#display_banner" do
    it "returns a string" do
      expect(subject.display_banner).to be_a(String)
    end
  end

  describe "#return_status_code" do
    it "returns a string" do
      expect(subject.return_status_code).to be_falsey
    end
  end

  describe "#status_json" do
    it "returns a string" do
      expect(subject.status_json).to be_a(String)
    end
  end

  describe "#generate_status_file" do
    it "creates a file" do
      old_count = Dir[status_file].count
      subject.generate_status_file
      expect(Dir[status_file].count).to eq(old_count + 1)
    end
  end
end
