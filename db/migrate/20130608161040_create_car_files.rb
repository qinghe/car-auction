class CreateCarFiles < ActiveRecord::Migration
  def self.up
    create_table :car_files do |t|
      t.references :car, :null => false, :default=>0
      t.string :description
      t.string  :uploaded_file_name
      t.integer :uploaded_file_size
      t.string  :uploaded_content_type
      t.string :type
      t.integer :user_id
      # 'type' would trigger Rails STI 
      #0:license_images, 1:frame_images, 2:car_images

      t.timestamps
    end
  end

  def self.down
    drop_table :car_files
  end
end
