module Pingan
  class QuotedPriceAgainMessage < MessageBase
    self.required_fields = [ :partnerAccount, :taskAuctionNo, :applyReason ]
  #{
    #    "partnerAccount":"拍卖公司标识",
    #    "taskAuctionNo":"拍卖编号",
    #    "applyReason":"申请原因"
    #}
    attr_accessor :partnerAccount,:taskAuctionNo, :applyReason

    def initialize( auction )
      taskAuctionNo = auction.serial_no
      applyReason = auction.apply_reason
      super
    end

  end
end
