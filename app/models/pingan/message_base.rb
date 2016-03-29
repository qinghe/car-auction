require 'builder'
module Pingan
  class MessageBase
    #YYYY-MM-DD HH24:MI:SS
    class_attribute :api_path, :required_fileds

    attr_accessor :auction, :partnerAccount

    def initialize( auction )
      self.auction = auction
      self.partnerAccount = Connector.client_id
    end

    # return  result.
    def post
      response = Connector.post( self )
      result = response.parsed
      touch_auction!( result )
      result
    end

    def to_xml()
      raise "please implement it"
    end

    def request_id
      "#{api_path.split('/').last}#{DateTime.current.to_i}"
    end


    def to_hash
      instance_values.symbolize_keys!()
    end


    def format_date_time( datatime )
      datetime.to_s(:db)
    end

    def touch_auction!( result )
      auction.last_api_name = self.class.name
      auction.last_api_succeed = result['succeed']
      auction.last_api_message = result['message']
      auction.save!
    end

  end
end
