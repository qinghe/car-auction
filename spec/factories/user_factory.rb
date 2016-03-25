FactoryGirl.define do
  factory :user , class: User do
    login 'david'
    name "David"
    email "david@example.com"
    password 'password'
    password_confirmation 'password'
    description 'it is required'

    trait :administrator do
      role 'administrator'
    end


  end
end
