module Pingan
  class MessageParser
    class_attribute :api_path

    attr_accessor :data

    def initialize( data )
      self.data = data
    end

    def perform

    end

    def attributes
      #elements = parse
      ##=> #(Element:0x208995c { name = "PARTNER_ID", children = [ #(Text "icclm_htbc")] })
      ##ele.name => "PARTNER_ID"
      ##ele.text => "icclm_htbc"
      #elements.inject({}){|hash, ele| hash[ele.name] = ele.text; hash }
      #s = {a: 1, b: 2}.to_json => "{\"a\":1,\"b\":2}"
      #ActiveSupport::JSON.decode(s) => {"a"=>1, "b"=>2}
      @attributes ||= parse
    end

    def parse
      #parser.xpath( xpath )
      begin
        ActiveSupport::JSON.decode(data)
      rescue ActiveSupport::JSON.parse_error
        Rails.logger.warn("Attempted to decode invalid JSON: #{data}")
      end
    end

    def partner_account
      attributes['partnerAccount']
    end

    def task_auction_no
      attributes['taskAuctionNo']
    end

    def task_auction
      @task_auction||=Auction.where( serial_no: task_auction_no ).last
    end

    def to_hash
      attributes
    end

#    def touch_auction!
#      task_auction.last_api_name = self.class.name
#      task_auction.save!
#    end

    def touch_history!( message,  result )
Rails.logger.debug " message = #{message} result=#{result.inspect}, #{ message.api_path}"
      action_history = ActionHistory.new
      action_history.auction_id = message.task_auction.id
      action_history.api_name = message.api_path
      action_history.api_params = message.to_json
      action_history.api_result = result.to_json
      action_history.save!
    end

  end
end
