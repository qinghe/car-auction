module Pingan
  class PriceResponse < DataHandler

    #<success>true</success>
    #<message>无</message>

    def xpath
      "RESPONSE/*"
    end
  end
end
