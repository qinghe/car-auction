class BlogCategory < ActiveRecord::Base
  acts_as_nested_set  

  attr_accessible :name
  
  has_many :blogposts, :foreign_key=>"category_id"
end
