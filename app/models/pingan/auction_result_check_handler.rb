module Pingan
  class AuctionResultCheckHandler < MessageParser

    #{
    #  "partnerAccount":"",
    #  "taskAuctionNo":"",
    #  "feedbackResult":"",
    #  "feedbackOpinion":""
    #}

    def perform
      result = BoolMessageWrapper.new( false )
      task_auction.feedback_result = attributes['feedbackResult']
      task_auction.feedback_opinion =  attributes['feedbackOpinion']
      result.succeed = task_auction.save
#Rails.logger.debug "AuctionResultCheckHandler attributes#{attributes.inspect}, task_auction=#{task_auction.inspect}"
      touch_auction! if result.succeed

      result
    end


  end
end
