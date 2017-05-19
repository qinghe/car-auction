module Pingan
  class ClientConfig
      include Singleton
      attr_accessor :client_id        #'P_DLHC_CLAIM'
      attr_accessor :client_name      #  '大连华宸'
      attr_accessor :client_secret    # 'acn385tr'
      attr_accessor :partner_account  # '610000010201'
      attr_accessor :site, :ver
      attr_accessor :bucket

      #Buket值：
      #测试环境：      icore-pts-openapi-dmz-stg-pri
      #生产环境：      icore-pts-openapi-dmz-prd-pri


      def initialize
        self.client_id = "P_DLHC_CLAIM"
        self.client_name = '大连华宸'
        self.client_secret = 'acn385tr'
        self.partner_account = '610000010201'
        self.site = 'https://test-api.pingan.com.cn:20443'
        self.bucket = "icore-pts-openapi-dmz-stg-pri"
      end
  end
end
