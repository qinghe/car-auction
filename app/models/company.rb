class Company < ActiveRecord::Base
  attr_accessible :name ,:description, :type , :is_approval, :approval, :approved_at
  scope :insurance_companies, where(:type=>'insurance')
end
