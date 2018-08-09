class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notify_comment.subject
  #

  default from: 'OWL <innodealing.qa@gmail.com>'
  layout 'mailer'

  def notify_error(project)
    @project = project
    @greeting = "Hey #{project.qa}"
    host = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}.ip_address
    @url = "http://#{host}:3003/projects/#{project.id}/scenarios"
    mail(to: 'cheng.dong@innodealing.com', subject: "Regression APIs Error")
  end

  private
  def filter_projects_result(results)
    @results = []
    results.each do |result|
      @results << result if result[0] == project.title
    end
  end
end
