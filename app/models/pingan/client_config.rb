module Pingan
  class ClientConfig
      include Singleton
      attr_accessor :client_id        #'P_DLHC_CLAIM'
      attr_accessor :client_name      #  '大连华宸'
      attr_accessor :client_secret    # 'acn385tr'
      attr_accessor :partner_account  # '610000010201'
      attr_accessor :site, :ver

      def initialize
        self.client_id = "P_DLHC_CLAIM"
        self.client_name = '大连华宸'
        self.client_secret = 'acn385tr'
        self.partner_account = '610000010201'
        self.site = 'https://test-api.pingan.com.cn:20443'
      end
  end
end
