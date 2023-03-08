require "spec_helper"
require "bonobot/status"

describe Bonobot::Status do
  subject(:status) { described_class.new(status_key) }

  let(:status_key) { nil }

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

  describe "#return_status_code" do
    it "returns a string" do
      expect(subject.return_status_code).to be_falsey
    end
  end
end