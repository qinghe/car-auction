
class AddAuctionImages < ActiveRecord::Migration

  def change
    #add_attachment :auctions, :bids_image
    #add_attachment :auctions, :transfer_image
    add_column :auctions, :iobs_token, :string
    add_column :auctions, :transfer_document_group_id, :string
  end

end
