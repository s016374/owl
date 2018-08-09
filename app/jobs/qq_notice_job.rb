require 'http'
require 'dotenv/load'

class QqNoticeJob < ApplicationJob
  queue_as :default

  def self.perform_qq_notice(project)
    host = ENV['HOST_IP'] || Socket.ip_address_list.detect{|intf| intf.ipv4_private?}.ip_address
    message = "#{project.title} FAIL: http://#{host}:3003/projects/#{project.id}/scenarios"
    data = {:group_id => ENV['QQ_GROUP'], :message => message, :is_raw => 'False'}
    HTTP['User-Agent':'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36','Content-Type': 'application/json']
      .post(ENV['QQ_URL'], json: data)
  end

end
