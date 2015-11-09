module Pingan
  class TransferMessageWrapper < BoolMessageWrapper

    #<TASKINQUIRENO>TASKINQUIRENO</TASKINQUIRENO> #拍卖编号
    #<TRAN_CODE>TRAN_CODE</TRAN_CODE>
    #<Complete_transfer >Complete_transfer</Complete_transfer>
    #<transfer_time>transfer_time</transfer_time>
    #{
    #  "partnerAccount":"",
    #  "taskAuctionNo":"",
    #  "transferTime":""
    #}
    attr_accessor :taskAuctionNo, :transferTime

    def initialize( auction )
      self.taskAuctionNo = auction.serial_no
      self.transferTime = ''
    end

  end
end
