module Pingan
  class IobsService
    attr_accessor :auction, :car_files

    def self.upload_bids_image( auction )
      success = false
      car_files =  auction.car.bid_images
      if car_files.present?
        service = new( auction, car_files )
        keys = service.call
        if keys.present?
          success = auction.update document_group_id: keys.join(',')
        end
      end
      success
    end

    def self.upload_transfer_image( auction )
      success = false
      car_files =  auction.car.transfer_images
      if car_files.present?
        service = new( auction, car_files )
        keys = service.call
        if keys.present?
          success = auction.update transfer_document_group_id: keys.join(',')
        end
      end
      success
    end

    def initialize( auction,car_files )
      self.auction = auction
      self.car_files =car_files
    end
    #Buket值：
    #测试环境：  icore-pts-openapi-dmz-stg-pri
    #生产环境：  icore-pts-openapi-dmz-prd-pri

    def call
      host=  ClientConfig.instance.iobs_url
   		bucket = ClientConfig.instance.bucket


   		token = get_token();
      keys = []
  		begin
        car_files.each{|file|
          key= get_key(file)
          url = host + "/upload/"+bucket + "/"+ key
       		file_path = file.uploaded.path
          response = HTTP.post(url, :form => {
            :token => token,
            :file   => HTTP::FormData::File.new(file_path)
          })
          Rails.logger.debug "url=#{url},file_path=#{file_path},response=#{response.inspect} "
          if response.code == 200
            keys << key
          end
        }

      rescue  => err
        Rails.logger.error "can not upload file caused by #{err.inspect}"
      end

      keys
    end

    def get_key( file )
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
