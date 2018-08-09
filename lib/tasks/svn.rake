namespace :svn do
  host=ENV['SVN_HOST']
  username=ENV['SVN_ACCOUNT']
  password=ENV['SVN_PASSWORD']
  branch_name=ENV['BRANCH_NAME']

  desc "usge: rails svn:checkout_branch_from_trunk BRANCH_NAME=20171031, default BRANCH_NAME is Today."
  task checkout_branch_from_trunk: :environment do
    branch_name ||= (Date.today + 6).strftime("%Y%m%d")
    exec %{svn cp --username #{username} --password #{password} #{host}/svn/DM-Repository/dm-quote-center/trunk #{host}/svn/DM-Repository/dm-quote-center/branches/#{branch_name} -m "copy brach from trunk by owl on #{Time.now.strftime("%y-%m-%d %k:%M:%S")}"}
  end

  desc "usge: rails svn:remove_branch BRANCH_NAME=20171031, default BRANCH_NAME is Today last week."
  task remove_branch: :environment do
    branch_name ||= (Date.today - 1).strftime("%Y%m%d")
    exec %{svn rm --username #{username} --password #{password} #{host}/svn/DM-Repository/dm-quote-center/branches/#{branch_name} -m "remove branch by owl on #{Time.now.strftime("%y-%m-%d %k:%M:%S")}"}
  end

end
