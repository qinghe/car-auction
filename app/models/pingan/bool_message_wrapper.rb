module Pingan
  class BoolMessageWrapper < MessageBase
    attr_accessor :succeed, :message

    def initialize( succeed= false, message=nil )
      self.succeed = succeed
      self.message = message
    end

    def to_json( options = {} )
      attributes.to_json
    end

    def attributes
      { succeed: succeed, message: message }
    end
  end
end
