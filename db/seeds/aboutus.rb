category = BlogCategory.create!(:name => '大连华宸价格评估', :short_name => 'company')

category.children.create({:name => '大连华宸价格评估', :short_name => 'aboutus'})

for node in category.reload.leaves
#  puts File.join(File.dirname(__FILE__),'seeds',node.short_name,"*")
  for file_path in Dir[File.join(File.dirname(__FILE__),node.short_name,"*")].sort
    open(file_path) do |file|      
      blogpost = node.blogposts.build
      blogpost.user_id = 1
      blogpost.title = file.gets
      blogpost.content = file.read
      blogpost.save!
    end
  end
end
