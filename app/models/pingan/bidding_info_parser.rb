module Pingan
  class BiddingInfoParser < MessageParser

    #{
    #  "partnerAccount":"",
    #  "taskAuctionNo":"",
    #  "inquireAmount":"",
    #  "biddingUser":""   =? '大连华宸'
    #}

    def perform
      result = BoolMessageWrapper.new( false )
      auction = Auction.where( serial_no: task_auction_no ).first
      if auction.present?
        auction.inquire_amount = attributes['inquireAmount']
        auction.bidding_user =  attributes['biddingUser']
        result.succeed = auction.save
      end
      result
    end

    def xpath
      "Request/*"
    end


    def win_bid?
      attributes['biddingUser'] == Connector.client_name
    end
  end
end
