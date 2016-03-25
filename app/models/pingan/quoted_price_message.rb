module Pingan
  class QuotedPriceMessage < MessageWrapper

    self.api_path = '/open/appsvr/property/receiveQuotedPrice'

    attr_accessor :taskAuctionNo, :auctionPrice, :remark

    def initialize( auction )
      self.partnerAccount = PartnerAccount
      self.taskAuctionNo = auction.serial_no
      self.auctionPrice =  auction.current_price
      self.remark = ''
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
