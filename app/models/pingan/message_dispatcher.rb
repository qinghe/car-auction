module Pingan
  class MessageDispatcher
    #TranCodeInEnum = Struct.new(
    #  :send_car_inquire_info,
    #  :send_highest_bidding_info,
    #  :receive_auction,
    #  :multi_inquire_feedback,
    #  :receive_auction_check,
    #  :receiveTransferInfoCheck ) ['sendCarInquireInfo','sendHighestBiddingInfo','receiveAuction', 'multiInquireFeedback', 'receiveAuctionCheck', 'receiveTransferInfoCheck' ]


    def self.perform( task_name,  message )
      #'sendCarInquireInfo','sendHighestBiddingInfo','receiveAuction', 'multiInquireFeedback', 'receiveAuctionCheck', 'receiveTransferInfoCheck'
      message_parser = case task_name
        when 'sendCarInquireInfo'
          CarInquireInfoParser.new( message )
        when 'sendHighestBiddingInfo'
          BiddingInfoParser.new( message )
        when 'receiveAuction'
          EntrustedMessageParser.new( message )
        when 'multiInquireFeedback'
          MultiInquireFeedbackHandler.new( message )
        when 'receiveAuctionCheck'
          AuctionResultCheckHandler.new( message )
        when 'receiveTransferInfoCheck'
          TransferInfoCheckParser.new( message )
        end

        result = message_parser.perform
        touch_history!( message_parser,  result )
        result
    end

    def self.touch_history!( message,  result )
Rails.logger.debug " message = #{message} result=#{result.inspect}"
      action_history = ActionHistory.new
      action_history.auction_id = message.task_auction.id
      action_history.api_name = message.class.name
      action_history.api_params = message.to_json
      action_history.api_result = result.to_json
      action_history.save!
    end

  end
end
