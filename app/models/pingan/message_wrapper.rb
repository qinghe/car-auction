require 'builder'
module Pingan
  class MessageWrapper
    #YYYY-MM-DD HH24:MI:SS
    PartnerAccount = 'P_DLHC_CLAIM'
    class_attribute :api_path

    attr_accessor :partnerAccount, :message

    def initialize( message )
      self.partnerAccount = PartnerAccount
      self.message = message
    end

    def post
      Connector.post( self )
    end

    def to_xml()
      raise "please implement it"
    end

    def request_id
      "#{api_path.split('/').last}#{DateTime.current.to_i}"
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

    #    xml = Builder::XmlMarkup.new
    #    xml.instruct! :xml, :version => '1.0', :encoding=>"GB2312"
    #    xml.Request  do
    #      xml.PARTNER_ID "icclm_htbc"
    #      xml.SUITE_NAME "PCIS"
    #      xml.TRAN_CODE tran_code
    #      yield xml if block_given?
    #    end

    end

    def to_hash
      instance_values
    end


    def format_date_time( datatime )
      datetime.to_s(:db)
    end

  end
end
