class CreateAuctions < ActiveRecord::Migration
  def self.up
    create_table :auctions do |t|
      t.boolean :private, :default => 0, :null => false
      t.boolean :delta, :default => false
      t.integer :status, :default => 0, :null => false
      t.integer :budget_id,:default => 0, :null => false
      t.references :owner,:default => 0, :null => false
      t.references :won_offer
      t.string :title, :length => 50, :null => false,:default => ''
      t.text :description, :length => 2000, :null => false
      t.boolean :highlight, :default => 0

      t.timestamp :expired_at, :default=>'1970-01-01 00:00:00'
      t.integer :offers_count, :default => 0
      t.integer :visits, :default => 0, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :auctions
  end
end
