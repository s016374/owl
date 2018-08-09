# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#init user admin
# user = User.create!(email: 'dgg@innodealing.com', password: '123456')
# 1.times do |i|
#   Job.create!(user_id: user.id, title: "title_#{i}", job_type: 'job_type', occupation: 'occupation',
#               company_name: 'company_name', location: 'location', url:'http://www.url.com', description: 'description',
#               apply_information: 'apply_information', deadline: 'deadline')
# end

User.create!(email: 'cheng.dong@innodealing.com', password: 'innodealingQA')
User.create!(email: 'bigqa@innodealing.com', password: '111111')

project = Project.create!(title: "bond-web", qa: 'shengyang.li@innodealing.com', schedule: '1h')
Scenario.create!(project_id: project.id, title:'违约概率排行', url: 'http://rest.innodealing.com/bond-web/api/bond/analysis/pdRank/indus?page=1&limit=5&sort=pdSortRRs%3Adesc', headers: 'Accept, Application/json, userid, 516733', method: 'get', cookies: '')
Scenario.create!(project_id: project.id, title: '查询-地区信息', url: 'http://rest.innodealing.com/bond-web/api/bondCity/bondArea?type=2', headers: 'Accept, Application/json, userid, 516733', method: 'get', cookies: '')

project = Project.create!(title: "bond-portfolio", qa: 'shengyang.li@innodealing.com', schedule: '1h')
Scenario.create!(project_id: project.id, title:'[投组] 获取投组列表', url: 'http://rest.innodealing.com/bond-portfolio-service/api/bond/portfolio/users/516733/groups', headers: 'Accept, Application/json', method: 'get', cookies: '')
Scenario.create!(project_id: project.id, title: '[投组] 获取投组雷达根节点/子节点列表', url: 'http://rest.innodealing.com/bond-portfolio-service/api/bond/portfolio/radar/nodes/0', headers: 'Accept, Application/json', method: 'get', cookies: '')
Scenario.create!(project_id: project.id, title:'[指标] 获取单支债券的财务指标列表', url: 'http://rest.innodealing.com/bond-portfolio-service/api/bond/portfolio/favorite/2222/radars/fina?userId=1111', headers: 'Accept, Application/json', method: 'get', cookies: '')
Scenario.create!(project_id: project.id, title: '[指标] 获取单支债券的财务指标列表', url: 'http://rest.innodealing.com/bond-portfolio-service/api/bond/portfolio/favorite/150632/radars/fina?userId=516733', headers: 'Accept, Application/json', method: 'get', cookies: '')

project = Project.create!(title: "online-web", qa: 'na.li@innodealing.com', schedule: '1h')
Scenario.create!(project_id: project.id, title:'线上-我的报价-已成交', url: 'http://rest.innodealing.com/online-web/api/quotes/dealtQuotes?pageSize=20&pageNum=1', headers: 'Accept, */*', method: 'get', cookies: '')
Scenario.create!(project_id: project.id, title: '线上-我的报价-匹配中', url: 'http://rest.innodealing.com/online-web/api/quotes/matchingQuotes?pageSize=20&pageNum=1', headers: 'Accept, */*', method: 'get', cookies: '')

project = Project.create!(title: "offline-web", qa: 'na.li@innodealing.com', schedule: '1h')
Scenario.create!(project_id: project.id, title:'获取用户已成交的自己报价', url: 'http://rest.innodealing.com/offline-web/api/completedQuotes?pageSize=20&pageNum=1', headers: 'Accept, */*', method: 'get', cookies: '')
Scenario.create!(project_id: project.id, title: '获取用户匹配中的自己报价', url: 'http://rest.innodealing.com/offline-web/api/matchingQuotes?pageSize=20&pageNum=1', headers: 'Accept, */*', method: 'get', cookies: '')

project = Project.create!(title: "deposit-web", qa: 'na.li@innodealing.com', schedule: '1h')
Scenario.create!(project_id: project.id, title:'获取一组报价基本信息', url: 'http://rest.innodealing.com/deposit-web/internalApi/quoteGroups/www', headers: 'Accept, */*', method: 'get', cookies: '')
Scenario.create!(project_id: project.id, title: '通过groupKey 获取同组的所有报价', url: 'http://rest.innodealing.com/deposit-web/internalApi/quoteGroups/qqq/quotes', headers: 'Accept, */*', method: 'get', cookies: '')

project = Project.create!(title: "finance-web", qa: 'na.li@innodealing.com', schedule: '1h')
Scenario.create!(project_id: project.id, title:'获取一条报价', url: 'http://rest.innodealing.com/finance-web/internalApi/quotes/111', headers: 'Accept, */*', method: 'get', cookies: '')
Scenario.create!(project_id: project.id, title: '获取最近market走势图', url: 'http://rest.innodealing.com/finance-web/api/market/financeMarket/quoteGroup/qew/assetCatId', headers: 'Accept, */*', method: 'get', cookies: '')

project = Project.create!(title: "irs-web", qa: 'na.li@innodealing.com', schedule: '1h')
Scenario.create!(project_id: project.id, title:'IRS-查询报价', url: 'http://rest.innodealing.com/irs-web/internalApi/quotes/1111', headers: 'Accept, */*', method: 'get', cookies: '')
Scenario.create!(project_id: project.id, title: '用户IRS权限列表', url: 'http://rest.innodealing.com/irs-web/api/funcs/all', headers: 'Accept, */*', method: 'get', cookies: '')

project = Project.create!(title: "deposit-app", qa: 'na.li@innodealing.com', schedule: '1h')
Scenario.create!(project_id: project.id, title:'大厅存单-高级筛选-选项json', url: 'http://rest.innodealing.com/deposit-app/app/api/advancedFiltrate/options', headers: 'Accept, */*', method: 'get', cookies: '')

project = Project.create!(title: "finance-app", qa: 'na.li@innodealing.com', schedule: '1h')
Scenario.create!(project_id: project.id, title:'大厅理财-高级筛选-选项json', url: 'http://rest.innodealing.com/finance-app/app/api/advancedFiltrate/options', headers: 'Accept, */*', method: 'get', cookies: '')

project = Project.create!(title: "offline-app", qa: 'na.li@innodealing.com', schedule: '1h')
Scenario.create!(project_id: project.id, title:'大厅线下-高级筛选-选项json', url: 'http://rest.innodealing.com/offline-app/app/api/advancedFiltrate/options', headers: 'Accept, */*', method: 'get', cookies: '')

project = Project.create!(title: "auth-service", qa: 'na.li@innodealing.com', schedule: '1h')
Scenario.create!(project_id: project.id, title:'通过sessionId判断用户是否登录中', url: 'http://rest.innodealing.com/auth-service/web/api/verified/session/wewr', headers: 'Accept, */*', method: 'get', cookies: '')
Scenario.create!(project_id: project.id, title: '通过sessionId获取user信息', url: 'http://rest.innodealing.com/auth-service/web/api/verified/session/www/user', headers: 'Accept, */*', method: 'get', cookies: '')

project = Project.create!(title: "meta-service", qa: 'na.li@innodealing.com', schedule: '1h')
Scenario.create!(project_id: project.id, title:'获取用户的所有权限', url: 'http://rest.innodealing.com/meta-service/user/id/500003/permissions', headers: 'Accept, */*', method: 'get', cookies: '')
Scenario.create!(project_id: project.id, title: '获取用户的密码', url: 'http://rest.innodealing.com/meta-service/user/qa_test/password', headers: 'Accept, */*', method: 'get', cookies: '')
