module Pingan
  class BoolMessageWrapper < MessageWrapper
    attr_accessor :succeed, :message

    def initialize( succeed= false, message=nil )
      self.succeed = succeed
      self.message = message
    end

    def to_json
      { succeed: succeed, message: message }.to_json
    end

    def to_xml( options = {} )
      get_xml do |xml|
        xml.succeed succeed
        xml.message message
      end
    end

  end
end
