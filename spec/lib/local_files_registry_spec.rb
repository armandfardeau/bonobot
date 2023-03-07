require "spec_helper"
require "bonobot/local_files_registry"
require "rails"

describe Bonobot::LocalFilesRegistry do
  subject(:registry) { described_class }

  before do
    allow(Bonobot::LocalFilesRegistry).to receive(:root).and_return(Pathname.new("spec/test_files"))
    allow(Rails).to receive(:root).and_return(Pathname.new("spec"))
  end

  describe ".all" do
    it "returns an array" do
      expect(registry.all).to be_an(Array)
      expect(registry.all.first).to be_a(Bonobot::LocalFile)
    end
  end

  describe ".output" do
    it "returns an array" do
      expect(registry.output).to be_an(Array)
      expect(registry.output.first).to be_a(Hash)
    end
  end
end