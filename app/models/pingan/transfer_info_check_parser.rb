module Pingan
  class TransferInfoCheckParser < MessageParser

    #{
    #    "partnerAccount":"",
    #    "taskAuctionNo":"",
    #    "transferResult":"",
    #    "transferOpinion":""
    #}

    def perform
      result = BoolMessageWrapper.new( false )
      task_auction.channel_transfer_result = attributes['transferResult']
      task_auction.channel_transfer_opinion =  attributes['transferOpinion']
      result.succeed = task_auction.save

      touch_history!( self,  result )

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
