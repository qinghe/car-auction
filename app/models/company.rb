class Company < ActiveRecord::Base
  attr_accessible :name ,:description, :company_type , :is_approval, :approval, :approved_at
  has_many :members, :class_name => "User"
  scope :insurance_companies, where(:company_type=>'insurance')
end
