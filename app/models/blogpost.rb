class Blogpost < ActiveRecord::Base
	attr_accessible :content, :title, :admin, :category_id

  belongs_to :user
  belongs_to :category, :class_name => "BlogCategory"
	has_many :blogcomments, :dependent => :destroy
	has_many :usefuls, :dependent => :destroy
	
	validates :title, :presence => true, :length => {:within => 2..100}
	validates :content, :presence => true, :length => {:within => 10..5000}
  	validates :user_id, :presence => true
	
	default_scope :order => 'blogposts.created_at DESC'
end
