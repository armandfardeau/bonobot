# frozen_string_literal: true

require "spec_helper"

describe Bonobot::Configuration do
  subject(:configuration) { described_class::Configuration.new }

  describe "#status_file" do
    it "returns the status file path" do
      expect(configuration.status_file).to eq("#{Rails.root}/status.json")
    end
  end

  describe "#status_file_path" do
    it "returns the status file path" do
      expect(configuration.instance_variable_get(:@status_file_path)).to eq(Rails.root)
    end
  end

  describe "#status_file_name" do
    it "returns the status file name" do
      expect(configuration.instance_variable_get(:@status_file_name)).to eq("status.json")
    end
  end

  describe "#included_dirs" do
    it "returns the included dirs" do
      expect(configuration.instance_variable_get(:@included_dirs)).to eq("{app}")
    end
  end

  describe "#files_pattern" do
    it "returns the files pattern" do
      expect(configuration.instance_variable_get(:@files_pattern)).to eq("{rb,erb}")
    end
  end

  describe "#fingerprint_algorithm" do
    it "returns the files pattern" do
      expect(configuration.instance_variable_get(:@fingerprint_algorithm)).to eq("md5")
    end
  end

  describe "#fingerprint_algorithm" do
    it "returns the files pattern" do
      expect(configuration.instance_variable_get(:@fingerprint_human_readable)).to be(false)
    end
  end

  describe "#config_value_for" do
    it "returns the config value for key" do
      expect(configuration.config_value_for(:status_file_path, Rails.root)).to eq(Rails.root)
    end
  end

  context "when config file is present" do
    let(:status_file_path) { "path" }
    let(:status_file_name) { "name" }
    let(:included_dirs) { %w(dir1 dir2) }
    let(:files_pattern) { %w(pat1 pat2) }

    before do
      allow(described_class::Configuration).to receive(:config_file).and_return({
                                                                                  status_file_path: status_file_path,
                                                                                  status_file_name: status_file_name,
                                                                                  included_dirs: included_dirs,
                                                                                  files_pattern: files_pattern,
                                                                                  fingerprint_algorithm: "sha1",
                                                                                  fingerprint_human_readable: true
                                                                                })
    end

    describe "#status_file" do
      it "returns the status file path" do
        expect(configuration.status_file).to eq("path/name.json")
      end
    end

    describe "#status_file_path" do
      it "returns the status file path" do
        expect(configuration.instance_variable_get(:@status_file_path)).to eq("path")
      end
    end

    describe "#status_file_name" do
      it "returns the status file name" do
        expect(configuration.instance_variable_get(:@status_file_name)).to eq("name.json")
      end
    end

    describe "#included_dirs" do
      it "returns the included dirs" do
        expect(configuration.instance_variable_get(:@included_dirs)).to eq("{dir1,dir2}")
      end
    end

    describe "#files_pattern" do
      it "returns the files pattern" do
        expect(configuration.instance_variable_get(:@files_pattern)).to eq("{pat1,pat2}")
      end
    end

    describe "#fingerprint_algorithm" do
      it "returns the files pattern" do
        expect(configuration.instance_variable_get(:@fingerprint_algorithm)).to eq("sha1")
      end
    end

    describe "#fingerprint_human_readable" do
      it "returns the files pattern" do
        expect(configuration.instance_variable_get(:@fingerprint_human_readable)).to be(true)
      end
    end
  end
end
