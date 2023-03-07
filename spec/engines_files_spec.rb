# frozen_string_literal: true

require "spec_helper"
require "bonobot/engines_files_registry"
require "rails/engine"

describe EnginesFiles do
  before do
    allow(::Rails::Engine).to receive(:subclasses).and_return([dummy_engine])
    allow(Bundler.rubygems).to receive(:gem_dir).and_return(gems_dir)
  end

  let(:gems_dir) { "/Users/username/.rbenv/versions/3.0.2/lib/ruby/gems/3.0.0" }

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
      expect(described_class.engine_to_name(dummy_engine)).to eq("dummy")
    end

    context "when engine has a railtie_namespace" do
      let(:dummy_engine) do
        double("DummyEngine",
               instance: double("instance", root: Pathname.new("./spec/fixture_files/dummy_engine")),
               engine_name: "dummy_engine",
               railtie_namespace: "Dummy::Admin")
      end

      it "returns the gem name" do
        expect(described_class.engine_to_name(dummy_engine)).to eq("dummy/admin")
      end
    end
  end

  describe ".engine_paths" do
    before do
      allow(File).to receive(:read).and_return("# frozen_string_literal: true")
    end

    let(:paths) { ["#{gems_dir}/gems/spec/fixture_files/dummy_engine/app/example_file.rb"] }

    it "returns the engine paths" do
      expect(described_class.engine_paths(paths)).to eq({
                                                          "fixture_files/dummy_engine/app/example_file.rb" => {
                                                            fingerprint: "3d826f91cfc807387499d3c63c365203",
                                                            path: "#{gems_dir}/gems/spec/fixture_files/dummy_engine/app/example_file.rb"
                                                          }
                                                        })
    end
  end
end
