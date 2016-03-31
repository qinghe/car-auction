module Pingan
  class MessageBase
    #YYYY-MM-DD HH24:MI:SS
    class_attribute :api_path, :required_fields
    self.required_fields = []

    attr_accessor :auction, :partnerAccount

    def initialize( auction )
      self.auction = auction
      self.partnerAccount = Rails.configuration.x.pingan['partner_account']
    end

    # return  result.
    def post
      response = Connector.post( self )
      result = response.parsed
      touch_history!( self, result )
      Rails.logger.debug " response = #{response.inspect} result=#{result.inspect}"
      #touch_auction!( result )
      result
    end

    def to_xml()
      raise "please implement it"
    end

    def request_id
      "#{api_path.split('/').last}#{DateTime.current.to_i}"
    end


    def to_hash
      instance_values.symbolize_keys().slice( *self.required_fields )
    end


    def format_date_time( datetime )
      datetime.to_s(:db)
    end

    # { "ret":"0",
    #    "msg":"",
    #    "requestId":"receiveQuotedPrice1459307406",
    #    "data":"{ "succeed":"false","message":"入参有为空的情况，请检查。" }
    #  }
    def touch_auction!( result )
      auction.last_api_name = self.class.name
      auction.last_api_succeed = result['data']['succeed']
      auction.last_api_message = result['data']['message']
      auction.save!
    end

    def touch_history!( message,  result )
#Rails.logger.debug " message = #{message} result=#{result.inspect}"
      action_history = ActionHistory.new
      action_history.auction_id = message.auction.id
      action_history.api_name = message.class.api_path
      action_history.api_params = message.to_json
      action_history.api_result = result.to_s
      action_history.save!
    end

  end
end
