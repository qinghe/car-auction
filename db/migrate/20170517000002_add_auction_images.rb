
class AddAuctionImages < ActiveRecord::Migration

  def change
    add_attachment :auctions, :bids_image
    add_attachment :auctions, :transfer_image
  end

end
