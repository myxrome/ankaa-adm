require 'resque/tasks'
require 'resque/scheduler/tasks'

task 'resque:setup' => :environment

namespace :resque do
  task :setup => [:environment] do
    require 'resque'
    require 'resque-scheduler'

    Resque.schedule = YAML.load_file("#{Rails.root}/config/schedule.yml")
  end
end