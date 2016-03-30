module Pingan
  class TransferInfoMessage < MessageBase
    self.api_path = '/open/appsvr/property/receiveAuctionTransfer'

    self.required_fields = [ :partnerAccount, :taskAuctionNo, :isAuction, :transferBail, :isPayTransferBail, :isPayAuctionPrice, :transferTime, :transferOpinion].sort!
    #{
    #  "partnerAccount":"",
    #  "taskInquireNo":"",
    #  "isAuction":"",
    #  "transferBail":
    #  "isPayTransferBail":"",
    #  "isPayAuctionPrice":"",
    #  "transferTime":  auction.transfer_real_time,
    #  "transferOpinion":""
    #}
    attr_accessor *required_fields
    #:taskAuctionNo, :isAuction, :transferBail, :isPayTransferBail, :isPayAuctionPrice, :transferTime, :transferOpinion

    def initialize( auction )
      self.taskAuctionNo = auction.serial_no
      self.isAuction = auction.is_auction
      self.transferBail = auction.transfer_bail
      self.isPayTransferBail = auction.is_pay_transfer_bail
      self.isPayAuctionPrice = auction.is_pay_auction_price
      self.transferTime = auction.transfer_real_time
      self.transferOpinion = auction.transfer_opinion
      super
    end

  end
end
