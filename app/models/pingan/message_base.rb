require 'builder'
module Pingan
  class MessageBase
    #YYYY-MM-DD HH24:MI:SS
    class_attribute :api_path

    attr_accessor :partnerAccount

    def initialize( auction )
      self.partnerAccount = Connector.client_id
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


    def to_hash
      instance_values
    end


    def format_date_time( datatime )
      datetime.to_s(:db)
    end

  end
end
