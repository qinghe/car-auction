module Pingan
  class IobsService
    attr_accessor :auction, :file

    def self.upload_bids_image( auction )
      service = new( auction )

      if auction.car.bid_images.present?
        service.call
      end
    end

    def initialize( auction )
      self.auction = auction
      self.file = auction.car.bid_images.first
    end
    #Buket值：
    #测试环境：  icore-pts-openapi-dmz-stg-pri
    #生产环境：  icore-pts-openapi-dmz-prd-pri

    def call
      host=  ClientConfig.instance.site
   		bucket = ClientConfig.instance.bucket
   		key= get_key
   		file_path = file.uploaded.path

      url = host + "/upload/"+bucket + "/"+ key
   		token = get_token();

  		begin
        response = HTTP.post(url, :form => {
          :token => token,
          :avatar   => HTTP::FormData::File.new(file_path)
        })
        Rails.logger.debug "url=#{url},file_path=#{file_path},response=#{response.inspect} "
        auction.update document_group_id: key
      rescue  => err
        Rails.logger.error "can not upload file caused by #{err.inspect}"
      end
    end

    def get_key
      "#{ClientConfig.instance.client_id}-#{ DateTime.current.to_i}-#{file.id}"
    end

    def get_token
      token = nil
      #{"ret"=>"0",
      #  "msg"=>"",
      #  "requestId"=>"claimGetTokenForIOBS1495161362",
      #  "data"=>
      #  {"token"=>
      #    "8CJK29FVFY2IK9W0Y8IIdKWD06MI202F:eNPzVnm9-q4y5Il6Frbm-ucmRXI=:eyJzY29wZSI6Imljb3JlLXB0cy1vcGVuYXBpLWRtei1zdGctcHJpIiwiZGVhZGxpbmUiOjE0OTUxNjIyNjJ9",
      #    "resultCode"=>"200",
      #    "resultMessage"=>"成功"}}
      result =  Pingan::ClaimGetTokenForIobsMessage.new(auction).post
      if result['ret'] == '0'
        token = result['data']['token']
      end
      token
    end
  end
end
