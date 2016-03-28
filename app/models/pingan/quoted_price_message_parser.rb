module Pingan
  class QuotedPriceMessageParser < MessageParser

    #<success>true</success>
    #<message>无</message>

    def xpath
      "RESPONSE/*"
    end
  end
end
