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
      if task_auction.is_entrust == EntrustingEnum.yes
        task_auction.commissioned_time = DateTime.current
      end
      result.succeed = task_auction.save
      touch_history!( self,  result )

      result
    end


  end
end
