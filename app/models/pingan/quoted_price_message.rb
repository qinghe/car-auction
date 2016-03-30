module Pingan
  class QuotedPriceMessage < MessageBase

    self.api_path = '/open/appsvr/property/receiveQuotedPrice'
    #{
    #    "partnerAccount":"",
    #    "taskAuctionNo":"",
    #    "auctionPrice":"",
    #    "remark":""
    #}
    self.required_fields = [ :partnerAccount, :taskAuctionNo, :auctionPrice, :remark]

    attr_accessor *required_fields

    def initialize( auction )
      self.taskAuctionNo = auction.serial_no
      self.auctionPrice =  auction.car.canzhi_jiazhi
      self.remark = auction.car.remark
      super
    end

    #def to_xml
    #  get_xml do |xml|
    #    xml.taskAuctionNo taskAuctionNo
    #    xml.auctionPrice auctionPrice
    #    xml.remark remark
    #  end
    #end

  end
end
