require 'builder'
module Pingan
  class MessageWrapper

    TranCodeOutEnum = Struct.new(:price, :auction, :transfer )['102018','002020','002021' ]

    attr_accessor :message
    def initialize( message )
      self.message = message
    end

    def post
      Connector.post( self )
    end

    def to_xml()
      raise "please implement it"
    end

    def tran_code
      raise "please implement it"
    end

    def get_xml
    #  <<-EOF
    #    <?xml version="1.0" encoding="GB2312"?>
    #    <Request>
    #      <PARTNER_ID>icclm_htbc</PARTNER_ID>
    #      <SUITE_NAME>PCIS</SUITE_NAME>
    #      <TRAN_CODE>102018</TRAN_CODE>
    #      <taskAuctionNo>taskAuctionNo</taskAuctionNo>
    #      <auctionPrice>auctionPrice</auctionPrice>
    #      <remark>remark</remark>
    #    </Request>
    #  EOF

        xml = Builder::XmlMarkup.new
        xml.instruct! :xml, :version => '1.0', :encoding=>"GB2312"
        xml.Request  do
          xml.PARTNER_ID "icclm_htbc"
          xml.SUITE_NAME "PCIS"
          xml.TRAN_CODE tran_code
          yield xml if block_given?
        end

    end
  end
end
