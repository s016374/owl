# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "log/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# every :thrusday, :at => '5am' do

# env :PATH, ENV['RAILS_ENV']

# usage:
# bundle exec whenever -i --set 'environment=development'
# bundle exec whenever -c
every :thursday, :at => '5am' do
  # rake 'svn:remove_branch'
  rake 'svn:checkout_branch_from_trunk'
end
