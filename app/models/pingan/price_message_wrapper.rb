module Pingan
  class PriceMessageWrapper < MessageWrapper
    attr_accessor :taskAuctionNo, :auctionPrice, :remark

    def initialize( auction )

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
