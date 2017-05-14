module Pingan
  class TransferInfoMessage < MessageBase
    self.api_path = '/open/appsvr/property/receiveAuctionTransfer'

    self.required_fields = [ :partnerAccount, :taskInquireNo, :isAuction, :transferBail,
      :isPayTransferBail, :isPayAuctionPrice, :transferTime, :transferOpinion,
      :transferBailPayDate, :documentGroupId].sort!
    #{
    #  "partnerAccount":"",
    #  "taskInquireNo":"",
    #  ?"isAuction":"",
    #  "transferBail":
    #  "isPayTransferBail":"",
    #  "isPayAuctionPrice":"",
    #  "transferTime":  auction.transfer_real_time,
    #  "transferOpinion":""
    #}
    # isPayTransferBail String 否 过户保证金是否支付
    # transferBailPayDate String 否 过户保证金支付时间
    # documentGroupId String 否 附件组ID

    attr_accessor *required_fields
    #:taskAuctionNo, :isAuction, :transferBail, :isPayTransferBail, :isPayAuctionPrice, :transferTime, :transferOpinion

    def initialize( auction )
      #self.taskAuctionNo = auction.serial_no
      self.taskInquireNo = auction.serial_no
      self.isAuction = auction.is_auction
      self.transferBail = auction.transfer_bail
      self.isPayTransferBail = auction.is_pay_transfer_bail
      self.isPayAuctionPrice = auction.is_pay_auction_price
      self.transferTime = auction.transfer_real_time
      self.transferOpinion = auction.transfer_opinion

      self.transferBailPayDate = auction.transfer_bail_pay_date
      self.documentGroupId = auction.document_group_id
      super
    end

  end
end
