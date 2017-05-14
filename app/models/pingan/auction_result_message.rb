module Pingan
  class AuctionResultMessage < MessageBase
    self.required_fields = [ :partnerAccount, :taskAuctionNo, :announcementStartTime,:announcementEndTime,
      :auctionLocation, :startTime, :endTime, :auctionType, :isPass, :passTimes,
      :commissionedTime, :transferComplete, :transferRequestTime, :transferRealTime,
      :finalPrice, :bidTimes, :isApplyInquire , :biddersList]

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

    # 2017-5
    # 增加“首款是否支付”、“首款支付时间” “溢价金额”、‘溢价是否支付’‘溢价支付时间’‘参拍人数’‘保全人员’‘保全时间’‘保全说明；

    #isPayFirstPrice    String    否    首款是否支付
    #firstPricePayDate    String    是    首款支付时间
    #premiumPrice    String    否    溢价金额
    #isPayPremium    String    否    溢价是否支付
    #premiumPayDate    String    是    溢价支付时间
    #competeNum    String    否    参拍人数
    #preservationUser    String    否    保全人员
    #preservationDate    String    否    保全时间
    #preservationDesc    String    否    保全说明
    #documentGroupId    String    否    附件组ID



    attr_accessor :taskAuctionNo, :announcementStartTime,:announcementEndTime,
      :auctionLocation, :startTime, :endTime, :auctionType, :isPass, :passTimes,
      :commissionedTime, :transferComplete, :transferRequestTime, :transferRealTime,
      :finalPrice, :bidTimes, :isApplyInquire, :biddersList,
      :isPayFirstPrice, :firstPricePayDate, :premiumPrice, :isPayPremium, :premiumPayDate,
      :competeNum, :preservationUser,:preservationDate,:preservationDesc, :documentGroupId
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
    #    "biddersList":[
    #        {
    #            "bidUser":"",
    #            "bidPrice":""
    #        }
    #    ]
    #}
    # {"partnerAccount":"610000010201","taskAuctionNo":"2016081700077734",
    #  "announcementStartTime":"2016-08-16 16:00:00","announcementEndTime":"2016-08-16 16:00:00","auctionLocation":"网络",
    #  "startTime":"2016-08-17 09:50:00","endTime":"2016-08-17 09:53:33","auctionType":"2","isPass":"Y","passTimes":"0",
    #  "commissionedTime":"2016-08-17 09:49:25","transferComplete":"N","transferRequestTime":"2016-08-16 16:00:00",
    #  "transferRealTime":"2016-08-16 16:00:00","finalPrice":"14500","bidTimes":"2","isApplyInquire":"N",
    #  "biddersList":[{"bidTime":"2016-08-17 09:52:40","bidUser":"华宸","bidPrice":"14100"},
    #                 {"bidTime":"2016-08-17 09:53:27","bidUser":"曲美玲","bidPrice":"14500"}]}
    def initialize( auction )
      self.taskAuctionNo = auction.serial_no
      self.announcementStartTime = auction.public_start_at
      self.announcementEndTime = auction.public_expired_at
      self.auctionLocation = auction.location
      self.startTime =  auction.start_at
      self.endTime =  auction.expired_at
      self.auctionType = auction.type_name
      self.isPass =  auction.is_pass || 'Y'
      self.passTimes =  auction.pass_times || '0'
      self.commissionedTime = auction.commissioned_time
      self.transferComplete =  auction.transfer_complete
      self.transferRequestTime =  auction.transfer_request_time
      self.transferRealTime =   auction.transfer_real_time
      self.finalPrice = auction.bidding_price
      self.bidTimes = auction.offers.count
      self.isApplyInquire = false
      self.biddersList = auction.offers.map{|offer|
        { bidTime: format_date_time(offer.created_at), bidUser: offer.offerer.name, bidPrice: offer.price }
      }

      self.isPayFirstPrice = auction.is_pay_first_price
      self.firstPricePayDate = auction.first_price_pay_date
      self.premiumPrice = auction.premium_price
      self.isPayPremium = auction.is_pay_premium
      self.premiumPayDate = auction.premium_pay_date
      self.competeNum = auction.offerers.count
      self.preservationUser = auction.preservation_user
      self.preservationDate = auction.preservation_date
      self.preservationDesc = auction.preservation_desc
      self.documentGroupId = auction.document_group_id

      super
    end

  end
end
