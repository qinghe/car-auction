#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# how to load seed 
# rake db:migrate:reset
# mysql -uroot < db/car_models.sql
# rake db:seed


# Users
admin =  User.create!(
  :login => "admin",
  :password => 'password',
  :name => "zhang",
  :lastname => "yunqi",
  :country => "cn",
  :email => "admin@example.com",
  :description => "欢迎。我是网站上的一名管理员。如果您有任何问题，联系我 :)"
)
admin.status = 2
admin.role = "administrator"
admin.save

CommentKeyword.create!(
  [{ :name => "联系" },
    { :name => "实现" },
    { :name => "与成员的关系" }
  ])

Budget.create([
    {:title => "< 500 zł"},
    {:title => "500 - 1000 zł"},
    {:title => "1000 - 2500 zł"},
    {:title => "2500 - 5000 zł"},
    {:title => "> 5000 zł"}
  ])
  
Role.create!(:name => 'guest')
Role.create!(:name => 'leader', :file => true, 
                                :forum => true,
                                :member => true,
                                :info => true,
                                :ticket => true)
Role.create!(:name => 'owner', :info => true)
Role.create!(:name => 'info_mod', :info => true)
Role.create!(:name => 'member_mod', :member => true)
Role.create!(:name => 'ticket_mod', :ticket => true)
Role.create!(:name => 'file_mod', :file => true)
Role.create!(:name => 'forum_mod', :forum => true)


category = BlogCategory.create!(:name => '帮助', :short_name => 'helps')

category.children.create({:name => '新手必读', :short_name => 'newer'})
category.children.create({:name => '业务指南', :short_name => 'bid'})
category.children.create({:name => '售后服务', :short_name => 'guarentee'})
category.children.create({:name => '常见问题', :short_name => 'faqs'})
#load blogs
for node in category.reload.leaves
#  puts File.join(File.dirname(__FILE__),'seeds',node.short_name,"*")
  for file_path in Dir[File.join(File.dirname(__FILE__),'seeds',node.short_name,"*")].sort
    open(file_path) do |file|      
      blogpost = node.blogposts.build
      blogpost.user_id = 1
      blogpost.title = file.gets
      blogpost.content = file.read
      blogpost.save!
    end
  end
end
  

#业务指南
#  竞价指南,  拍卖前需做什么准备,  拍卖佣金,  中标后如何提车,  提车时效
#新手指南
#  注册流程,  参拍流程,  提车流程,  vip大厅付款规则,  社会车辆拍卖厅规则,  企业会员,  微信公众平台如何加入
#售后服务
#  出现拆检, 出现丢件, 过户费率
#常见问题
#  什么是二次事故
#  关于违约
#  过户维修时效保证金
#  什么是保留价
#  现场拍卖会

#关于华晨
#  公司简介,  发展历程,  合作单位,  机构分布,  联系我们,  公司账户,  招贤纳士
#免责声明
#  免责声明
#法律声明
#  法律声明
#保证金缴纳
#  保证金缴纳
#VIP专享
#  VIP专享

#source car_models.sql instead, it is too slow running rake.
#`rake car:initial_models RAILS_ENV=#{Rails.env}`
#load File.join(File.dirname(__FILE__),"samples.rb")
puts "load sql seed"
`mysql -uroot < #{File.join(Rails.root,'db','car_models.sql')}`
puts "complete load seeds"
