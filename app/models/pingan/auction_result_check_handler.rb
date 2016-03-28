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

      touch_auction! if result.succeed

      result
    end


  end
end
