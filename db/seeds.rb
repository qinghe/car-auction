#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

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


BlogCategory.create!(:name => 'member')      #会员中心
BlogCategory.create!(:name => 'auction_help')#竞价
BlogCategory.create!(:name => 'aboutus')


`rake car:initial_models RAILS_ENV=#{Rails.env}`
