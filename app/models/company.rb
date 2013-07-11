class Company < ActiveRecord::Base
  acts_as_nested_set
  attr_accessible :parent_id, :name ,:description, :company_type , :is_approval, :approval, :approved_at
  has_many :members, :class_name => "User"
  scope :insurance_companies, where(:company_type=>'insurance')

  def all_members
    self.self_and_descendants.inject([]){|members,company|members+=company.members}
  end
end
