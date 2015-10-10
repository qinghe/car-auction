class Company < ActiveRecord::Base
  acts_as_nested_set
  #attr_accessible :parent_id, :name ,:description, :company_type , :is_approval, :approval, :approved_at, :address, :agent_name, :agent_id, :company_id
  has_many :members, :class_name => "User"
  scope :insurance_companies, ->{ where(:company_type=>'insurance') }

  has_attached_file :agent_id, :styles => { :thumb => "100x100>" }, :default_url => "/images/avatars/missing.png"
  has_attached_file :company_id, :styles => { :thumb => "100x100>" }, :default_url => "/images/avatars/missing.png"

  def all_members
    self.self_and_descendants.inject([]){|members,company|members+=company.members}
  end
end
