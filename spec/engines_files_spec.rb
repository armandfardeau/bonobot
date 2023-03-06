# frozen_string_literal: true

require "spec_helper"
require "bonobot/engines_files"
require "rails/engine"

describe EnginesFiles do
  before do
    allow(::Rails::Engine).to receive(:subclasses).and_return([dummy_engine])
  end

  let(:dummy_engine) do
    double("DummyEngine",
           instance: double("instance", root: Pathname.new("./spec/fixture_files/dummy_engine")),
           engine_name: "dummy_engine")
  end

  describe ".files" do
    it "returns all the files" do
      expect(described_class.files).to be_a(Hash)
      expect(described_class.files).to eq({
                                            "dummy" => {
                                              "spec/fixture_files/dummy_engine/app/example_file.rb" => {
                                                path: "./spec/fixture_files/dummy_engine/app/example_file.rb",
                                                fingerprint: "7735d96c25272f92678b60f2f68758c2"
                                              }
                                            }
                                          })
    end
  end

  describe ".fingerprint" do
    it "returns a fingerprint" do
      expect(described_class.fingerprint("./spec/fixture_files/dummy_engine/app/example_file.rb")).to eq("7735d96c25272f92678b60f2f68758c2")
    end
  end

  describe ".engine_name" do
    it "returns the gem name" do
      expect(described_class.engine_name(dummy_engine)).to eq("dummy")
    end

    context "when engine has a railtie_namespace" do
      let(:dummy_engine) do
        double("DummyEngine",
               instance: double("instance", root: Pathname.new("./spec/fixture_files/dummy_engine")),
               engine_name: "dummy_engine",
               railtie_namespace: "Dummy::Admin::Engine")

        it "returns the gem name" do
          expect(described_class.engine_name(dummy_engine)).to eq("dummy/admin")
        end
      end
    end
  end
end
