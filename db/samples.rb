#encoding: utf-8
def make_companies
  names = ['华晨评估公司','平安保险公司','华安保险公司','太平洋保险公司','人保财险']
  types = ['evaluating','insurance','insurance','insurance','insurance']
  names.each_index do |i|    
    Company.create!(
        :name => names[i],
        :description => '',
        :company_type => types[i],
        :is_approval => 1 ,
        :approval => '',
        :approved_at => Time.now
    )
    user = User.create!(
      :login => "publisher#{i}",
      :password => 'password',
      :name => names[i][0,2],
      :lastname => '',
      :status => 2,
      :email => "b#{i}@example.com",
      :description => "我是#{names[i]}的工作人员。"
    )
    user.update_attribute( :role, types[i] )
  end
end
make_companies
load File.join(Rails.root,'db','sample_cars','cars.rb')

