# frozen_string_literal: true

require "spec_helper"
require "bonobot/engines_files"

describe EnginesFiles do
  describe ".fingerprint" do
    it "returns a fingerprint" do
      expect(described_class.fingerprint("./spec/fixture_files/dummy_engine/example_file.rb")).to eq("7735d96c25272f92678b60f2f68758c2")
    end
  end
end
