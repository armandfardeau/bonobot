require "digest"
require "digest/bubblebabble"

module Bonobot::Fingerprint
  include Bonobot::Configuration
  ALGORITHM = { "md5" => Digest::MD5, "sha1" => Digest::SHA1, "sha256" => Digest::SHA256 }.freeze

  def self.calculate(path)
    algorithm.send(method, File.read(path))
  end

  def self.method
    if configuration.fingerprint_human_readable == "bubblebabble"
      :bubblebabble
    else
      :hexdigest
    end
  end

  def self.algorithm
    ALGORITHM.fetch(configuration.fingerprint_algorithm, Digest::MD5)
  end
end