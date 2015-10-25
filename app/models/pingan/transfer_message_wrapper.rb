module Pingan
  class TransferMessageWrapper < BoolMessageWrapper

    #<TASKINQUIRENO>TASKINQUIRENO</TASKINQUIRENO> #拍卖编号
    #<TRAN_CODE>TRAN_CODE</TRAN_CODE>
    #<Complete_transfer >Complete_transfer</Complete_transfer>
    #<transfer_time>transfer_time</transfer_time>
    attr_accessor :task_inquire_no, :tran_code, :complete_transfer, :transfer_time

    def initialize( auction )

    end

    def to_xml
      get_xml do |xml|
        xml.TASKINQUIRENO task_inquire_no
        xml.Complete_transfer complete_transfer
        xml.transfer_time transfer_time
      end
    end

  end
end
