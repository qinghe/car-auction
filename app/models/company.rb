class Company < ActiveRecord::Base
  scope :insurance_companies, where(:type=>'insurance')
end
