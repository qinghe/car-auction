module Pingan
  class TrustMessageParser < MessageParser
    #{
    #    "partnerAccount":"",
    #    "taskAuctionNo":"",
    #    "isEntrust":""
    #}
    def perform
      result = BoolMessageWrapper.new( false )
      auction = task_auction
      if auction.present?
        auction.is_entrust = attributes['isEntrust']
        result.succeed = auction.save
      end
      result
    end


  end
end
