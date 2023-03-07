require 'spec_helper'
require 'bonobot/local_file'
require "rails"

describe Bonobot::LocalFile do
  let(:current_dir) { Dir.getwd }
  let(:path) { "#{current_dir}/spec/test_files/annoted_example_file.rb" }

  before do
    allow(Rails).to receive(:root).and_return(current_dir)
  end

  describe ".new" do
    it "has a path" do
      expect(described_class.new(path).path).to eq("spec/test_files/annoted_example_file.rb")
    end
  end

  describe "#annotation" do
    it "returns the annotation" do
      expect(described_class.new(path).annotation).to eq("1234")
    end

    context "when the file has no annotation" do
      let(:path) { "#{current_dir}/spec/test_files/example_file.rb" }

      it "returns nil" do
        expect(described_class.new(path).annotation).to be_nil
      end
    end

    context "when the file is an ERB file" do
      let(:path) { "#{current_dir}/spec/test_files/annoted_example_file.html.erb" }

      it "returns the annotation" do
        expect(described_class.new(path).annotation).to eq("1234")
      end
    end
  end
end