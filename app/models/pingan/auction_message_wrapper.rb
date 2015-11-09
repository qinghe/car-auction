module Pingan
  class AuctionMessageWrapper < MessageWrapper

    #ANNOUNCEMENT_TIME    拍卖公示时间      auction.public_start_at
    #AUCTION_LOCATION     拍卖地点       N  auction.location
    #START_TIME           拍卖开始时间      auction.start_at
    #END_TIME             拍卖结束时间      auction.expired_at
    #AUCTION_TYPE         拍卖形式       N  acution.type_name
    #IS_PASS              是否流拍       N  auction.is_pass
    #PASS_TIMES           流拍次数       N  auction.pass_times
    #COMMISSIONEDTIME     接受委托时间    N auction.commissioned_time
    #TRANSFER_COMPLETE    是否完成过户   N  auction.transfer_complete
    #TRANSFER_REQUEST_TIME要求过户时间   N  auction.transfer_request_time
    #TRANSFER_REAL_TIME   实际过户时间   N  auction.transfer_real_time
    #FINAL_PRICE          拍卖成交价        auction.won_offer_id

    #BID_TIMES            出价次数
    #BID_USER             出价人           auction.won_offer_id
    #BID_ PRICE           出价             auction.won_offer_id

    attr_accessor :taskAuctionNo, :announcementStartTime,:announcementEndTime,
      :auctionLocation, :startTime, :endTime, :auctionType, :isPass, :passTimes,
      :commissionedTime, :transferComplete, :transferRequestTime, :transferRealTime,
      :finalPrice, :bidTimes, :bidList
    #{
    #    "partnerAccount":"",
    #    "taskAuctionNo":"",
    #    "announcementStartTime":"",
    #    "announcementEndTime":"",
    #    "auctionLocation":"",
    #    "startTime":"",
    #    "endTime":"",
    #    "auctionType":"",
    #    "isPass":"",
    #    "passTimes":"",
    #    "commissionedTime":"",
    #    "transferComplete":"",
    #    "transferRequestTime":"",
    #    "transferRealTime":"",
    #    "finalPrice":"",
    #    "bidTimes":"",
    #    "bidList":[
    #        {
    #            "bidUser":"",
    #            "bidPrice":""
    #        }
    #    ]
    #}
    def initialize( auction )
      self.partnerAccount = PartnerAccount
      self.taskAuctionNo = ''
      self.announcementStartTime = ''
      self.announcementEndTime = ''
      self.auctionLocation = ''
      self.startTime = ''
      self.endTime = ''
      self.auctionType = ''
      self.isPass = ''
      self.passTimes = ''
      self.commissionedTime = ''
      self.transferComplete = ''
      self.transferRequestTime = ''
      self.transferRealTime = ''
      self.finalPrice = ''
      self.bidTimes = ''
      self.bidList = []
    end

    def to_json

    end


  end
end
