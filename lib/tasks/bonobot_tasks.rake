# frozen_string_literal: true

namespace :bonobot do
  desc "Generate status"
  task status: :environment do
    status = Bonobot::Status.generate
    exit 1 unless status
  end

  namespace :status do
    desc "Generate status for out of date"
    task out_of_date: :environment do
      Bonobot::Status.generate(:out_of_date)
    end

    task outdated: :out_of_date

    desc "Generate status for missing"
    task missing: :environment do
      Bonobot::Status.generate(:missing)
    end

    desc "Generate status for up to date"
    task up_to_date: :environment do
      Bonobot::Status.generate(:up_to_date)
    end

    task uptodate: :up_to_date

    desc "Generate status for unused"
    task unused: :environment do
      Bonobot::Status.generate(:unused)
    end
  end

  desc "Add missing fingerprint to local files"
  task add_missing: :environment do
    Bonobot::FilesOp.add_missing
  end

  desc "Update out of date fingerprint to local files"
  task update_out_of_date: :environment do
    Bonobot::FilesOp.update_out_of_date
  end

  task update_outdated: :update_out_of_date
  task update: :update_out_of_date
end
