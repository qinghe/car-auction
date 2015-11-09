module Pingan
  class MessageDispatcher < MessageParser
    #<TRAN_CODE>200406</TRAN_CODE>
    PartnerAccount = 'P_DLHC_CLAIM'
    TranCodeInEnum = Struct.new(:send_car_inquire_info,
      :send_highest_bidding_info,
      :receive_auction )['sendCarInquireInfo','sendHighestBiddingInfo','receiveAuction' ]


    def self.perform( task_name,  message )
      dispatcher = new( message )

        message_parser = case task_name
        when TranCodeInEnum.send_car_inquire_info
          CarMessageParser.new( message )
        when TranCodeInEnum.send_highest_bidding_info
          BiddingMessageParser.new( message )
        when TranCodeInEnum.receive_auction
          TrustMessageParser.new( message )
        end

        result = message_parser.perform

    end


    def xpath
      "//TRAN_CODE"
    end

  end
end
