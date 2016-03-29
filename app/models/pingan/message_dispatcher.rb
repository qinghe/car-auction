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
          CarMessageParser.new( message )
        when 'sendHighestBiddingInfo'
          BiddingMessageParser.new( message )
        when 'receiveAuction'
          TrustMessageParser.new( message )
        when 'multiInquireFeedback'
          MultiInquireFeedbackHandler.new( message )
        when 'receiveAuctionCheck'
          AuctionResultCheckHandler.new( message )
        when 'receiveTransferInfoCheck'
          TransferInfoCheckParser.new( message )
        end

        result = message_parser.perform

    end


    def xpath
      "//TRAN_CODE"
    end

  end
end
