FactoryGirl.define do
  factory :auction , class: Auction do
    serial_no 'auction_number'
    starting_price 1000
    car
  end
end
