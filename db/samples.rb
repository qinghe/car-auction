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
  5.times do |i|
    login = Faker::Internet.user_name
    description = Faker::Lorem.sentence(12)
    firstname = Faker::Name.first_name
    lastname = Faker::Name.last_name
    user = User.create!(
      :login => login,
      :password => 'password',
      :name => firstname,
      :lastname => lastname,
      :role => ((i%2)==0 ? 'insurance_company':'evaluating_company'),
      :status => 2,
      :email => "#{i+2}@example.com",
      :description => description
    )
    user.status = 2
    user.company_id = ((i%2)==0 ? ((i/2)==0 ? 1 : 2) : 3)
    user.save
  end
end  

make_companies
make_users
load File.join(Rails.root,'db','sample_cars','cars.rb')

