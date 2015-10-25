module Pingan
  class BoolMessageWrapper < MessageWrapper
    attr_accessor :succeed, :message, :tran_code

    def initialize( succeed= false, tran_code=nil, message=nil )
      self.succeed = succeed
      self.tran_code = tran_code

    end

    def to_xml( options = {} )
      get_xml do |xml|
        xml.succeed succeed
        xml.message message
      end
    end

  end
end
