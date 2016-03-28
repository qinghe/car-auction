module Pingan
  class EntrustedMessageParser < MessageParser
    EntrustingEnum = Struct.new( :yes, :no, :inquire, :unknown)[ '1', '2', '3', '0']
    #{
    #    "partnerAccount":"",
    #    "taskAuctionNo":"",
    #    "isEntrust":""
    #}
    def perform
      result = BoolMessageWrapper.new( false )
      task_auction.is_entrust = attributes['isEntrust']
      result.succeed = task_auction.save

      touch_auction! if result.succeed 

      result
    end


  end
end
