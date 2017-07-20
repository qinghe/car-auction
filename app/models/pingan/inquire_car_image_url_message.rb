module Pingan
  class InquireCarImageUrlMessage < MessageBase

    self.api_path = '/open/appsvr/property/receiveInquireCarImgUrl'
    #{
    #    "partnerAccount":"",
    #    "taskAuctionNo":"",
    #    "auctionPrice":"",
    #    "remark":""
    #}
    attr_accessor :taskInquireNo
    self.required_fields = [ :partnerAccount, :taskInquireNo, :documentIdList]

    attr_accessor *required_fields

    def initialize( auction )
      self.taskInquireNo = auction.serial_no
      self.documentIdList = auction.car.document_id_list.split(',').to_s
      super
    end

  end
end
