
class AddBiddingUser < ActiveRecord::Migration

  def change
    #get from api/sendBidding
    add_column :auctions, :inquire_amount, :string
    add_column :auctions, :bidding_user, :string
    #get from api/receiveAuction
    add_column :auctions, :is_entrust, :string
  end

end
