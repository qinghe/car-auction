module Pingan
  class MessageParser
    attr_accessor :data

    def initialize( data )
      self.data = data
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


    def xpath
      raise "please implement"
    end

    def parser
      #Nokogiri::XML( data )
    end


  end
end
