#encoding: utf-8
def make_companies
  names = ['平安保险公司','人寿保险公司','华晨评估公司']
  types = ['insurance','insurance','evaluating']
  3.times do |i|
    Company.create!(
        :name => names[i],
        :description => '',
        :type => types[i],
        :is_approval => 1 ,
        :approval => '',
        :approved_at => Time.now
    )

  end
end

def make_users
  user = User.create!(
      :login => 'insurance_person',
      :password => 'password',
      :name => 'ming',
      :lastname => 'li',
      :role => 'insurance_company',
      :status => 2,
      :email => "pingan@example.com",
      :description => '我是平安保险的工作人员。'
  )
  user.role = 'insurance_company'
  user.status = 2
  user.company_id = 1
  user.save

  user = User.create!(
      :login => 'evaluating_person',
      :password => 'password',
      :name => 'li',
      :lastname => 'zhang',
      :status => 2,
      :email => "huachen@example.com",
      :description => '我是华晨的工作人员。'
  )
  user.role = 'evaluating_company'
  user.status = 2
  user.company_id = 3
  user.save

  user = User.create!(
      :login => 'renshou_insurance_person',
      :password => 'password',
      :name => 'hua',
      :lastname => 'yang',
      :role => 'insurance_company',
      :status => 2,
      :email => "renshou@example.com",
      :description => '我是人寿保险的工作人员。'
  )
  user.role = 'insurance_company'
  user.status = 2
  user.company_id = 2
  user.save

end  

make_companies
make_users
load File.join(Rails.root,'db','sample_cars','cars.rb')

