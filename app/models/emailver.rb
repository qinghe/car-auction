class Emailver < ActiveRecord::Base
	#attr_accessible :hash_mail, :user_id
  belongs_to :user

  validates :hash_mail, :presence => true
  validates :user_id, :presence => true
end
