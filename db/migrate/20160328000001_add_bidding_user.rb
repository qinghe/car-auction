
class AddBiddingUser < ActiveRecord::Migration

  def change
    add_column :auctions, :last_api_name, :string
    add_column :auctions, :last_api_succeed, :string
    add_column :auctions, :last_api_message, :string

    #get from api/sendBidding
    add_column :auctions, :inquire_amount, :string
    add_column :auctions, :bidding_user, :string

    #get from api/receiveAuction
    add_column :auctions, :is_entrust, :string

    # api/receiveQuotedPriceAgain
    add_column :auctions, :apply_reason, :string

    # multiInquireFeedback
    add_column :auctions, :inquire_result, :string
    add_column :auctions, :inquire_opinion, :string

    # receiveAuctionCheck
    add_column :auctions, :feedback_result, :string
    add_column :auctions, :feedback_opinion, :string

    # receiveAuctionTransfer
    add_column :auctions, :is_auction, :boolean, null: false, default: false
    add_column :auctions, :transfer_bail, :decimal, null:false, default: 0.0
    add_column :auctions, :is_pay_transfer_bail, :boolean, null: false, default: false
    add_column :auctions, :is_pay_auction_price, :boolean, null: false, default: false
    add_column :auctions, :transfer_opinion, :string

    #
  end

end
