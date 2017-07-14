module Pingan
  class InquireCarImageUrlMessage < MessageBase

    self.api_path = '/open/appsvr/property/receiveInquireCarImgUrl'
    #{
    #    "partnerAccount":"",
    #    "taskAuctionNo":"",
    #    "auctionPrice":"",
    #    "remark":""
    #}
    self.required_fields = [ :partnerAccount, :taskAuctionNo, :documentIdList]

    attr_accessor *required_fields

    def initialize( auction )
      self.taskAuctionNo = auction.serial_no
      self.documentIdList = auction.car.document_id_list
      super
    end

  end
end
