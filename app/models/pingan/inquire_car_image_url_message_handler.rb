module Pingan
  class InquireCarImageUrlMessageHandler

    attr_accessor :auction, :parsed_result

    def initialize( auction, parsed_result)
      self.auction = auction
      self.parsed_result = parsed_result
    end

    #{"ret"=>"0",
    # "msg"=>"",
    # "requestId"=>"receiveInquireCarImgUrl1500540526",
    # "data"=>
    #  {"succeed"=>"true",
    #   "message"=>"获取车辆询价图片路径成功!",
    #   "data"=>

    def perform
      parsed_data = parsed_result['data']
      Rails.logger.debug "-----------parsed_data['succeed']---------------=#{parsed_data.keys}"
      if parsed_data['succeed'] == 'true'
        urldata = JSON.parse( parsed_data['data'] )
        Rails.logger.debug "-----------urldata---------------=#{urldata.inspect}"
        if urldata['urlList'].present?
          url = urldata['urlList'].join(',')
          auction.car.update_attribute(:url, url)
        end
      end
    end
  end
end
