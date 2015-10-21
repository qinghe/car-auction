module Pingan
  class CarInfo
    include ActiveModel::Serializers::Xml

    attr_accessor :taskAuctionNo, :modelName

    def attributes=(hash)
      hash.each do |key, value|
        send("#{key}=", value)
      end
    end

  end

end
