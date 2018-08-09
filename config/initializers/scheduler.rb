# require 'rufus-scheduler'
#
# s = Rufus::Scheduler.singleton
#
# unless defined?(Rails::Console) || File.split($0).last == 'rake'
#   s.cron '0 5 * * 1-5' do
#     Project.all.each do |project|
#       ProjectsController.new.regres
#     end
#   end
# end

Rails.application.config.after_initialize do
  Scenario.new.get_session!
  Project.new.init_active!
end
