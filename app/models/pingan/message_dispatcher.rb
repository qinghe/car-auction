module Pingan
  class MessageDispatcher < MessageParser
    #<TRAN_CODE>200406</TRAN_CODE>
    TranCodeInEnum = Struct.new(:car, :bidding, :trust )['200406','200407','200408' ]


    def self.perform( message )
      dispatcher = new( message )

      element = dispatcher.parse.first

      message_parser = case element.try(:text)
      when TranCodeInEnum.car
        CarMessageParser.new( message )
      when TranCodeInEnum.bidding
        BiddingMessageParser.new( message )
      when TranCodeInEnum.trust
        TrustMessageParser.new( message )
      end

      result = message_parser.perform

    end


    def xpath
      "//TRAN_CODE"
    end

  end
end
