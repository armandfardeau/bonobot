# frozen_string_literal: true

require "bonobot/status"

namespace :bonobot do
  desc "Generate status"
  task status: :environment do
    status = Bonobot::Status.generate
    exit 1 unless status
  end
end
