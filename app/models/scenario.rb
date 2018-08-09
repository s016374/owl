class Scenario < ApplicationRecord
  belongs_to :project

  delegate :title, to: :project, prefix: true

  validates :method, :url, presence: true
  validates :title, presence: true, length: {minimum: 3, maximum: 30, message: ": minimum: 3, maximum: 30"}
  validates_format_of :url, :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix, message: ": URL format"
  validates_format_of :method, :with => /\Aget|post|put|delete|patch\z/, message: "support: get, post, put, delete, patch"
  before_validation :set_defaults

  METHODS = {get: 'get', post: 'post', delete: 'delete', put: 'put', patch: 'patch'}.freeze

  def run_case(scenario)
    scenario.update(updated_at: Time.now)
    res = run! scenario, @cookies
    assert! scenario, res
    # [scenario.project.title, scenario.title, scenario.status, res] is a bad smell.
    # Law of Demeter
    # refactor scenario.project.title => scenario.project_title
    # and, on models/scenario.rb delegate :title, to: :project, prefix: true
    [scenario.project_title, scenario.title, scenario.status, res]
  end

  def assert!(scenario, res)
    if res == 'HTTPError'
      scenario.update(status: "Fail ( Timeout/Others )")
      return
    end
    if res.status.to_s == scenario.expected_status
      if res.body.to_s.include?(scenario.expected_body)
        scenario.update(status: "Pass ( #{res.status} )")
      else
        scenario.update(status: "Fail ( Body Error )")
      end
    else
      scenario.update(status: "Fail ( #{res.status} )")
    end
  end

  def run!(scenario, cookies)
    headers = Hash[*scenario.headers.delete(' ').split(',')]
    a = scenario.cookies.delete(' ').split(',')
    cookies = get_login_session(a[0]||=ENV['PROD_USER'], a[1]||=ENV['PROD_PASSWORD'], a[2]||='prod', false)
    begin
      res = case scenario.method
            when METHODS.fetch(:get)
              HTTP[headers].cookies(cookies).get(scenario.url)
            when METHODS.fetch(:post)
              HTTP[headers].cookies(cookies).post(scenario.url, json: eval(scenario.body))
            when METHODS.fetch(:put)
              HTTP[headers].cookies(cookies).put(scenario.url, json: eval(scenario.body))
            when METHODS.fetch(:delete)
              HTTP[headers].cookies(cookies).delete(scenario.url, json: eval(scenario.body))
            when METHODS.fetch(:patch)
              HTTP[headers].cookies(cookies).patch(scenario.url, json: eval(scenario.body))
            else
              raise ArgumentError, "Unsupported Method: #{method}"
      end
    rescue
      res = 'HTTPError'
    end
    res
  end

  def get_login_session(username, password, env, is_sid=true)
    if env =~ /prod/
      url = ENV['DM_URL'] + '/auth-service/signin'
    elsif env =~ /qa/
      url = ENV['DM_QA_URL'] + '/auth-service/signin'
    else
      return 'plz + /env (prod, qa)'
    end
    res = HTTP.get(url)
    csrf = res.to_s.split('name="_csrf" value="').last.split('"/>').first
    sid = res.cookies.inspect.to_s.split('"sid", value="').last.split('",').first
    res = HTTP[content_type: 'application/x-www-form-urlencoded']
              .cookies('sid' => sid, 'uid' => ENV['TEST_UID'], 'UM_distinctid' => ENV['TEST_UM_DISTINCTID'])
              .post(url, :body => "_csrf=#{csrf}&username=#{username}&password=#{password}")
    sid = res.cookies.inspect.to_s
    return 'auth error' if sid.include? '@jar={}'
    sid = sid.split('"sid", value="').last.split('",').first
    return sid if is_sid
    { sid: sid, uid: ENV['TEST_UID'], UM_distinctid: ENV['TEST_UM_DISTINCTID'] }
  end

  def get_session!
    Rufus::Scheduler.new.schedule_every('1d') do
      @cookies = Scenario.new.get_login_session
    end
    @cookies
  end

  private
  def set_defaults
    self.title.try(:strip!)
    self.headers = 'Accept, */*' if self.headers.blank?
    self.status = '-' if self.status.blank?
    self.expected_status = '200 OK' if self.expected_status.blank?
    self.expected_body = 'success' if self.expected_body.blank?
    self.active = 0 if self.active.blank?
    self.method = 'get' if self.method.blank?
    self.cookies = '' if self.method.blank?
  end
end
