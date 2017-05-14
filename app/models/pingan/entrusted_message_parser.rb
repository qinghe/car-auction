module Pingan
  # 委托拍卖 平安 -> 華宸
  class EntrustedMessageParser < MessageParser
    EntrustingEnum = Struct.new( :yes, :no, :inquire_again, :unknown)[ '1', '2', '3', '0']
    #{
    #    "partnerAccount":"",
    #    "taskAuctionNo":"",
    #    "isEntrust":""
    #    transferBail: ""
    #    payOutType: "" 1：赔付实际价值减去过户保证金,2：赔付实际价值减去拍卖款,3：赔付实际价值（后续追偿拍卖款）,99：其他
    #}
    def perform
      result = BoolMessageWrapper.new( false )
      task_auction.is_entrust = attributes['isEntrust']
      if task_auction.is_entrust == EntrustingEnum.yes
        # 2017-5-14 added
        task_auction.transfer_bail = attributes['transferBail'].to_i
        task_auction.pay_out_type = attributes['payOutType']
        task_auction.commissioned_time = DateTime.current
      end
      result.succeed = task_auction.save
      touch_history!( self,  result )

      result
    end


  end
end
