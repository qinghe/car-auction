module Pingan
  class InquireCarImageUrlMessageHandler

    attr_accessor :auction, :parsed_result

    def initialize( auction, parsed_result)
      self.auction = auction
      self.parsed_result = parsed_result
    end

    def perform
      if parsed_result['succeed'] == 'true'
        if parsed_result['data']['url'].present?
          url = parsed_result['data']['url'].join(',')
          auction.car.update_attribute(:url, url)
        end
      end
    end
  end
end
