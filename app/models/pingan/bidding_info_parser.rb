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
      task_auction.inquire_amount = attributes['inquireAmount']
      task_auction.bidding_user =  attributes['biddingUser']
      result.succeed = task_auction.save

      touch_history!( self,  result )
      result
    end

    def xpath
      "Request/*"
    end


    def win_bid?
      attributes['biddingUser'] ==  Rails.configuration.x.pingan['client_name']
    end
  end
end
