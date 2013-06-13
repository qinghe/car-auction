class AddUserPhone < ActiveRecord::Migration
  def up
    add_column :auctions, :auctioneer_id, :integer, :default=>1
    add_column :auctions, :car_id, :integer, :default=>0
    #add_column :auctions, :remarks, :string, :length=>500    
    add_column :auctions, :start_at, :datetime
    add_column :auctions, :starting_price, :float, :default=>0          #起拍价
    add_column :auctions, :increment, :float, :default=>0 
    add_column :auctions, :reserve_price, :float, :default=>0 #保留价 
    add_column :auctions, :deposit, :float, :default=>0       #拍卖保证金    
    add_column :auctions, :system, :integer, :default=>0 #拍卖规则 0：倒计时出价， 1：一口价，  
    add_column :auctions, :hall, :integer, :default=>0   #拍卖厅， 0:倒计时出价大厅   1:vip,  
    add_column :users, :business_phones, :string
    add_column :users, :cellphone, :string
    
  end

  def down
    remove_column :auctions,:car_id, :auctioneer_id, :start_at,:starting_price, :increment, :reserve_price，:deposit
    remove_column :users, :business_phones, :cellphone
  end
end
