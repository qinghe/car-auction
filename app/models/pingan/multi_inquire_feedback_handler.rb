module Pingan
  class MultiInquireFeedbackHandler < MessageParser
    InquireResultEnum = Struct.new( :ok, :no )['1','2']
    #{
    #    "partnerAccount":"",
    #    "taskAuctionNo":"",
    #    "inquireResult":"",
    #    "inquireOpinion":""
    #}
    def perform
      result = BoolMessageWrapper.new( false )
Rails.logger.debug "MultiInquireFeedbackHandler attributes=#{attributes.inspect}"
      task_auction.inquire_result = attributes['inquireResult']
      task_auction.inquire_opinion = attributes['inquireOpinion']
      result.succeed = task_auction.save
      touch_auction! if result.succeed
      result
    end

  end
end
