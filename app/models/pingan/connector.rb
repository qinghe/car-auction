require 'net/https'
require 'uri'
require 'oauth2'

# pingan                                             huachen
#  sendCarInquireInfo        ->
#                                <-   receiveQuotedPrice ()
#  sendHighestBiddingInfo    ->
#  receiveAuction(entrusted) ->
#                                <-   receiveQuotedPriceAgain
#  multiInquireFeedback      ->
#                                <-   receiveAuctionResult
#  receiveAuctionCheck       ->
#                                <-   receiveAuctionTransfer
#  receiveTransferInfoCheck


#http://test-api.pingan.com.cn:20080/
module Pingan
  class Connector
    class << self
      attr_accessor :site, :client_id, :client_secret, :auth_url, :debug_mode, :client_name

      def debug_mode?
        !!@debug_mode
      end

      #def is_connected?
      #  token = get_token
      #  #https://test-api.pingan.com.cn:20443/open/appsvr/property/œÓ¿ÚÃû?access_token=xxxxxxxx&request_id=œÓ¿ÚÃû+Ê±ŒäŽÁ
      #end

      def get_token
        token = nil
        user = User.administrator
        if user.access_token.present?
          token = OAuth2::AccessToken.from_hash(get_client, expires_at: user.token_expired_at )
          if  token.expires?
            token = token.refresh!
            user.access_token = token.token
            user.token_updated_at =  DateTime.current
            user.token_expires_in = token.expires_in
          end
        else
          token = generate_token
          user.access_token = token.token
          user.token_updated_at =  DateTime.current
          user.token_expires_in = token.expires_in
        end

        user.save!
        token

      end

      def generate_token
        client = get_client
        #{"ret":"0","data":{"expires_in":"43199","openid":"P_DLHC_CLAIM00","access_token":"C32D6F49CF9B4292839FDAC1CC36E79C"},"msg":""}
        response = client.client_credentials.get_token( {parse: :pingan_oauth2}, { 'auth_scheme'=> 'request_body' })
      end

      def get_client
        client = OAuth2::Client.new( client_id, client_secret,
          site: site,
          token_url: '/oauth/oauth2/access_token',
          token_method: :get,
        )
      end

    end


    def self.post(message_wrapper)

      #uri = URI.parse('https://222.68.184.181:8107')
      #http = Net::HTTP.new(uri.host, uri.port)
      #http.use_ssl = true  # enable SSL/TLS
      ##http.cert =OpenSSL::X509::Certificate.ne(File.read("D:/111/client.crt"))
      ##http.key =OpenSSL::PKey::RSA.new((File.read("D:/111/client.key")), "123456")# key and password
      #http.verify_mode = OpenSSL::SSL::VERIFY_NONE #这个也很重要

      #http.post(uri.path, message_wrapper.to_json) {|response|
      #    print response.body
      #}
      token = get_token
      path = message_wrapper.api_path + '?' + {access_token: token.token, request_id: message_wrapper.request_id}.to_param
      token.post( path, params: message_wrapper.to_hash) {|response|
          print response.body
      }

    end



  end
end
