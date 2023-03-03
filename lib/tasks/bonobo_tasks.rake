# frozen_string_literal: true

require "bonobo/status"

namespace :bonobo do
  desc "Generate status"
  task status: :environment do
    status = Bonobo::Status.generate
    exit 1 unless status
  end
end
