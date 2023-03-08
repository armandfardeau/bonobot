# frozen_string_literal: true

require "spec_helper"

describe Bonobot::Fingerprint do
  describe ".calculate" do
    let(:path) { "spec/test_files/example_file.rb" }
    let(:fingerprint) { Bonobot::Fingerprint.calculate(path) }

    it "returns a fingerprint" do
      expect(fingerprint).to eq("a0b74d09e2e0c75465ac4e9fca741208")
    end

    {
      "md5" => [
        "a0b74d09e2e0c75465ac4e9fca741208",
        "xomar-lefob-nymev-becah-gunep-sefen-zadal-gogob-myxyx"
      ],
      "sha1" => [
        "a3f5941bfeecae8a2889cf65cc5672cba78a5f53",
        "xomoz-hehoc-ryzav-surym-pupim-nifek-hafah-kasus-rinum-paloh-fyxix"
      ],
      "sha256" => [
        "00c6ad564b9b3dec7a25eb39bdd9dacc02cd2df0a7d18e20590e0e52b8abd88e",
        "xebas-keruh-kodun-razev-suvud-hopif-nazot-nokis-sibis-teroz-bunut-cufud-bykob-vofeh-dyvop-rekim-vaxex"
      ]
    }.each do |algorithm, expected_fingerprint|
      context "when algorithm is #{algorithm}" do
        before do
          allow(Bonobot::Fingerprint.configuration).to receive(:fingerprint_algorithm).and_return(algorithm)
        end

        it "returns a fingerprint" do
          expect(fingerprint).to eq(expected_fingerprint.first)
        end

        context "when method is bubblebabble" do
          before do
            allow(Bonobot::Fingerprint.configuration).to receive(:fingerprint_human_readable).and_return(true)
          end

          it "returns a fingerprint" do
            expect(fingerprint).to eq(expected_fingerprint.last)
          end
        end
      end
    end

    context "when the file is not found" do
      let(:path) { "spec/test_files/not_found.rb" }

      it "raises an error" do
        expect { fingerprint }.to raise_error(Errno::ENOENT)
      end
    end
  end
end
