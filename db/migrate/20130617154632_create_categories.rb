class CreateCategories < ActiveRecord::Migration
  def up
    create_table :blog_categories do |t|
      t.string :name
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.timestamps
    end
  end
  
  def down
    drop_table :blog_categories
  end
end
