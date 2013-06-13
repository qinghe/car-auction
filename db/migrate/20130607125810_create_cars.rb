# encoding: utf-8
class CreateCars < ActiveRecord::Migration
  def self.up
    create_table :cars do |t|
      t.integer :model_id
      t.string :model_name
      t.string :serial_no
      t.date :registered_at
      t.boolean :is_at
      t.string :displacement, :length=>24 #排量
      t.string :plate_number
      t.string :engine_number
      t.string :frame_number
      t.integer :status
      t.timestamps
    end
  end
  def self.down
    drop_table :cars
  end
end
