module Pingan
  class MessageWrapper
    attr_accessor :message
    def initialize( message )
      self.message = message
    end
#<?xml version="1.0" encoding="GB2312"?>
#<Request>
#<PARTNER_ID>icclm_htbc</PARTNER_ID>
#<SUITE_NAME>PCIS</SUITE_NAME>
#<TRAN_CODE>102018</TRAN_CODE>
#<taskAuctionNo>taskAuctionNo</taskAuctionNo>
#<auctionPrice>auctionPrice</auctionPrice>
#<remark>remark</remark>
#</Request>
    def from_xml( xml )
    end

    def to_xml
      <<-EOF
        <?xml version="1.0" encoding="GB2312"?>
        <Request>
          <PARTNER_ID>icclm_htbc</PARTNER_ID>
          <SUITE_NAME>PCIS</SUITE_NAME>
          <TRAN_CODE>102018</TRAN_CODE>
          <taskAuctionNo>taskAuctionNo</taskAuctionNo>
          <auctionPrice>auctionPrice</auctionPrice>
          <remark>remark</remark>
        </Request>
      EOF

      #  xml = Builder::XmlMarkup.new
      #  xml.instruct! :xml, :version => '1.0', :encoding=>"GB2312"
      #  xml.Request  do
      #    xml.PARTNER_ID "icclm_htbc"
      #    xml.SUITE_NAME "PCIS"
      #    xml.TRAN_CODE "102018"
            message.instance_values.each_pair{|key,val|

            }
      #  end

    end
  end
end
