class DmController < ApplicationController
  skip_before_action :authenticate_user!
  http_basic_authenticate_with name: "bigqa", password: "bigqa"

  def svn_merge_trunk
    comment = "merge branch to trunk by owl on #{Time.now.strftime("%y-%m-%d %k:%M:%S")}"
    system "svn co --username #{ENV['SVN_ACCOUNT']} --password #{ENV['SVN_PASSWORD']} #{ENV['SVN_HOST']}/svn/DM-Repository/dm-quote-center/trunk tmp_svn"
    system "cd tmp_svn && svn merge --username #{ENV['SVN_ACCOUNT']} --password #{ENV['SVN_PASSWORD']} #{ENV['SVN_HOST']}/svn/DM-Repository/dm-quote-center/branches/#{params[:branch_name]}"
    system %{cd tmp_svn && svn commit -m "#{comment}" --username #{ENV['SVN_ACCOUNT']} --password #{ENV['SVN_PASSWORD']}}
    system "rm -rf tmp_svn"
  end

  def svn_rm_branch
    comment = "remove branch by owl on #{Time.now.strftime("%y-%m-%d %k:%M:%S")}"
    system %{svn rm --username #{ENV['SVN_ACCOUNT']} --password #{ENV['SVN_PASSWORD']} #{ENV['SVN_HOST']}/svn/DM-Repository/dm-quote-center/branches/#{params[:branch_name]} -m "#{comment}"}
  end

  def svn_cp_branch
    comment = "copy brach from trunk by owl on #{Time.now.strftime("%y-%m-%d %k:%M:%S")}"
    system %{svn cp --username #{ENV['SVN_ACCOUNT']} --password #{ENV['SVN_PASSWORD']} #{ENV['SVN_HOST']}/svn/DM-Repository/dm-quote-center/trunk #{ENV['SVN_HOST']}/svn/DM-Repository/dm-quote-center/branches/#{params[:branch_name]} -m "#{comment}"}
  end
end
