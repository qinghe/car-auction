class CreateCarFiles < ActiveRecord::Migration
  def self.up
    create_table :car_files do |t|
      t.references :car, :null => false
      t.text :description, :null => false, :length => 500
      t.string :car_file_file_name
      t.integer :car_file_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :car_files
  end
end
