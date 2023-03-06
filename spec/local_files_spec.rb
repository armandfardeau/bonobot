# frozen_string_literal: true

require "spec_helper"
require "rails"
require "bonobot/local_files"

describe LocalFiles do
  let(:root_path) { Pathname.new(Dir.getwd.to_s) }

  describe ".files" do
    before do
      allow(::Rails).to receive(:root).and_return(root_path)
      allow(::Rails.root).to receive(:join).and_return("#{root_path}/spec/fixture_files/app/**/*.{erb,rb}")
    end

    it "returns a hash of files" do
      expect(described_class.files).to be_a(Hash)
      expect(described_class.files).to eq({
                                            "spec/fixture_files/app/empty_example_file.html.erb" => nil,
                                            "spec/fixture_files/app/empty_example_file.rb" => nil,
                                            "spec/fixture_files/app/example_file.html.erb" => "123456",
                                            "spec/fixture_files/app/example_file.rb" => "123456",
                                            "spec/fixture_files/app/example_file_with_multiple_annotations.html.erb" => "123456",
                                            "spec/fixture_files/app/syntax_error.rb" => nil
                                          })
    end
  end

  describe ".read_annotation" do
    it "returns an annotation" do
      expect(described_class.read_annotation("./spec/fixture_files/app/empty_example_file.html.erb")).to be_nil
      expect(described_class.read_annotation("./spec/fixture_files/app/empty_example_file.rb")).to be_nil
      expect(described_class.read_annotation("./spec/fixture_files/app/example_file.rb")).to eq("123456")
      expect(described_class.read_annotation("./spec/fixture_files/app/example_file.html.erb")).to eq("123456")
    end

    context "when there is multiple annotations" do
      it "returns the first annotation" do
        expect(described_class.read_annotation("./spec/fixture_files/app/example_file.html.erb")).to eq("123456")
      end
    end

    context "when there is no annotation" do
      it "returns nil" do
        expect(described_class.read_annotation("./spec/fixture_files/app/empty_example_file.html.erb")).to be_nil
      end
    end

    context "when there is a syntax error" do
      it "returns nil" do
        expect(described_class.read_annotation("./spec/fixture_files/app/syntax_error.rb")).to be_nil
      end
    end
  end
end
