module Pingan
  class PriceAgainMessageWrapper < MessageWrapper
    attr_accessor :taskAuctionNo, :auctionPrice, :remark

    def initialize( auction )
      self.partnerAccount = PartnerAccount
      self.taskAuctionNo = ''
      self.auctionPrice = 0
      self.remark = ''
    end

    def to_xml
      get_xml do |xml|
        xml.taskAuctionNo taskAuctionNo
        xml.auctionPrice auctionPrice
        xml.remark remark
      end
    end

  end
end
