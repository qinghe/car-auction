class AddUserPhone < ActiveRecord::Migration
  def up
    add_column :auctions, :auctioneer_id, :integer, :default=>1
    add_column :auctions, :car_id, :integer, :default=>0
    add_column :auctions, :remarks, :string, :length=>500    
    add_column :auctions, :start_at, :datetime
    add_column :auctions, :price, :float, :default=>0
    add_column :auctions, :increase, :float, :default=>0 
    add_column :auctions, :reserved_price, :float, :default=>0 
    add_column :users, :business_phones, :string
    add_column :users, :cellphone, :string
    
  end

  def down
    remove_column :auctions,:car_id, :auctioneer_id, :remarks,:start_at,:price, :increase, :reserved_price
    remove_column :users, :business_phones, :cellphone
  end
end
