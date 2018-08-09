class Project < ApplicationRecord
  has_many :scenarios, dependent: :destroy

  validates :title, presence: true, length: {minimum: 3, maximum: 30, message: ": minimum: 3, maximum: 30"}
  validates_format_of :qa, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, message: ": Email format"
  validates_format_of :schedule, :with => /\A(\d|[0-5]\d)s\z|\A(\d|[0-5]\d)m\z|\A(\d|1[\d]|2[0-3])h\z/, message: ": e.g. 30s, 20m, 1h"
  validates :title, :qa, presence: true

  before_validation :set_defaults

  @@jobs = {}

  def regres!(results)
    Project.all.each do |project|
      results << run_project(project)
      unless project.status.to_s =~ /Healthy/
        message = "API error, http://192.168.14.12:3003/projects/#{project.id}"
        HTTP.post(ENV['OCTOPUS'], json: {auth_token: 'bigqa', text: message})
        QqNoticeJob.perform_qq_notice(project) if ENV['DATABASE_URL'].include?('192.168.')
        UserMailer.notify_error(project).deliver_later!
      end
    end
    results
  end

  def active!(results)
    schedule = Rufus::Scheduler.new
    self.update(active: 1)
    job = schedule.schedule_every(self.schedule, tag: "#{self.title}") do
      results << run_project(self)
      unless self.status.to_s =~ /Healthy/
        HTTP.post(ENV['OCTOPUS'], json: {auth_token: 'bigqa', text: message})
        QqNoticeJob.perform_qq_notice(self) if ENV['DATABASE_URL'].include?('192.168.')
        UserMailer.notify_error(self).deliver_later!
      end
    end
    @@jobs.merge!(self.title.to_sym => job)
    results
  end

  def deactive!
    @@jobs[self.title.to_sym].unschedule unless @@jobs[self.title.to_sym] == nil
    self.update(active: 0)
  end

  def init_active!
    Project.all.each do |project|
      if project.active == 1
        schedule = Rufus::Scheduler.new
        job = schedule.schedule_every(project.schedule, tag: "#{project.title}") do
          run_project(project)
          unless project.status.to_s =~ /Healthy/
            HTTP.post(ENV['OCTOPUS'], json: {auth_token: 'bigqa', text: message})
            QqNoticeJob.perform_qq_notice(project) if ENV['DATABASE_URL'].include?('192.168.')
            UserMailer.notify_error(project).deliver_later!
          end
        end
        @@jobs.merge!(project.title.to_sym => job)
      end
    end
  end

  def run_project(project)
    res = []
    project.update(updated_at: Time.now)
    project.update(status: 'Healthy')
    project.scenarios.all.each do |scenario|
      r = Scenario.new.run_case scenario
      res << r
      project.update(status: 'Fail') unless r[2].to_s =~ /Pass/
    end
    res
  end

  private
  def set_defaults
    self.title.try(:strip!)
    self.qa = 'wan.yang@innodealing.com' if self.qa.blank?
    self.status = '-' if self.status.blank?
    self.active = 0 if self.active.blank?
  end
end
