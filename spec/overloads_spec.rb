# frozen_string_literal: true

require "spec_helper"
require "bonobot/overloads_registry"
require "bonobot/local_files_registry"
require "bonobot/engines_files_registry"

describe Overloads do
  describe ".files" do
    before do
      allow(LocalFiles).to receive(:files).and_return({ "app/dummy/missing.html.erb" => nil,
                                                        "app/missing.rb" => nil,
                                                        "app/dummy/outdated.html.erb" => "123456",
                                                        "app/dummy/outdated.rb" => "123457",
                                                        "app/dummy/up_to_date.html.erb" => nil,
                                                        "app/dummy/up_to_date.rb" => nil,
                                                        "app/example_file_with_multiple_annotations.html.erb" => "123456",
                                                        "app/syntax_error.rb" => nil })
      allow(EnginesFiles).to receive(:files).and_return({ "dummy" => {
                                                          "app/dummy/missing.html.erb" => {
                                                            path: "dummy/app/overload.html.erb",
                                                            fingerprint: "123456"
                                                          },
                                                          "app/dummy/missing.rb" => {
                                                            path: "dummy/app/overload.rb",
                                                            fingerprint: "123456"
                                                          },
                                                          "app/dummy/outdated.html.erb" => {
                                                            path: "dummy/app/outdated.html.erb",
                                                            fingerprint: "123456"
                                                          },
                                                          "app/dummy/outdated.rb" => {
                                                            path: "dummy/app/outdated.rb",
                                                            fingerprint: "123456"
                                                          },
                                                          "app/dummy/up_to_date.html.erb" => {
                                                            path: "dummy/app/up_to_date.html.erb",
                                                            fingerprint: "123456"
                                                          },
                                                          "app/dummy/up_to_date.rb" => {
                                                            path: "dummy/app/up_to_date.rb",
                                                            fingerprint: "123456"
                                                          }
                                                        } })
    end

    it "returns a hash" do
      expect(OverloadsRegistry.alls).to be_a(Hash)
      expect(OverloadsRegistry.alls).to eq({
                                      missing: [
                                        ["dummy", { path: "dummy/app/overload.html.erb", fingerprint: "123456", short_path: "app/dummy/missing.html.erb" }],
                                        ["dummy", { path: "dummy/app/up_to_date.html.erb", fingerprint: "123456", short_path: "app/dummy/up_to_date.html.erb" }],
                                        ["dummy", { path: "dummy/app/up_to_date.rb", fingerprint: "123456", short_path: "app/dummy/up_to_date.rb" }]
                                      ],
                                      up_to_date: [
                                        ["dummy", { path: "dummy/app/outdated.html.erb", fingerprint: "123456", short_path: "app/dummy/outdated.html.erb" }]
                                      ],
                                      out_of_date: [
                                        ["dummy", { path: "dummy/app/outdated.rb", fingerprint: "123456", short_path: "app/dummy/outdated.rb" }]
                                      ]
                                    })
    end

    it "returns a hash with the status keys" do
      expect(OverloadsRegistry.alls.keys).to eq([:missing, :up_to_date, :out_of_date])
    end
  end

  describe ".status_key" do
    let(:source_fingerprint) { " abc " }
    let(:target_fingerprint) { " abc " }

    it "returns : up_to_date" do
      expect(Overloads.status_key(source_fingerprint, target_fingerprint)).to eq(:up_to_date)
    end

    context "when source_fingerprint is different from target_fingerprint" do
      let(:target_fingerprint) { " def " }

      it "returns :out_of_date" do
        expect(Overloads.status_key(source_fingerprint, target_fingerprint)).to eq(:out_of_date)
      end
    end

    context "when target_fingerprint is nil" do
      let(:target_fingerprint) { nil }

      it "returns : missing" do
        expect(Overloads.status_key(source_fingerprint, target_fingerprint)).to eq(:missing)
      end
    end
  end

  describe ".status" do
    before do
      allow(Overloads).to receive(:files).and_return({ missing: ["aaaaa"], up_to_date: ["bbbb"], out_of_date: ["cccc"] })
    end

    it "returns the status" do
      expect(Overloads.status(:missing)).to eq(["aaaaa"])
      expect(Overloads.status(:up_to_date)).to eq(["bbbb"])
      expect(Overloads.status(:out_of_date)).to eq(["cccc"])
    end
  end
end
