require "bonobo/status"

namespace :bonobo do
  desc "YOOOOO"
  task :status => :environment do
    Bonobo::Status.generate
  end
end
