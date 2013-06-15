class CreateCarModels < ActiveRecord::Migration
  def up
    create_table :car_models do |t|
      t.string :name
      t.string :initial
      t.string :full_name # self.parent.name + self.name, car.model.full_name
      t.boolean :is_foreign, :default=>false
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      t.timestamps
    end
  end
  
  def down
    drop_table :car_models
  end
end
