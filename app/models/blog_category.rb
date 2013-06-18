class BlogCategory < ActiveRecord::Base
  acts_as_nested_set  

  attr_accessible :name
end
