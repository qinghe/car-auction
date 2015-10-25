module Pingan
  class MessageParser
    attr_accessor :data

    def initialize( data )
      self.data = data
    end

    def attributes
      elements = parse
      #=> #(Element:0x208995c { name = "PARTNER_ID", children = [ #(Text "icclm_htbc")] })
      #ele.name => "PARTNER_ID"
      #ele.text => "icclm_htbc"
      elements.inject({}){|hash, ele| hash[ele.name] = ele.text; hash }
    end

    def parse
      parser.xpath( xpath )
    end

    def xpath
      raise "please implement"
    end

    def parser
      Nokogiri::XML( data )
    end


  end
end
