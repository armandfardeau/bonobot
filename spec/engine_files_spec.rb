require "spec_helper"
require "bonobot/engines_files"

describe EnginesFiles do
  describe ".fingerprint" do
    it "returns a fingerprint" do
      expect(described_class.fingerprint("./spec/fixture_files/dummy_engine/example_file.rb")).to eq("d41d8cd98f00b204e9800998ecf8427e")
    end
  end
end