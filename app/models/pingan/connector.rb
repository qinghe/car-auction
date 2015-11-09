require 'net/https'
require 'uri'
module Pingan
  class Connector
    #https://222.68.184.181:8107
    def self.post(message_wrapper)

      uri = URI.parse('https://222.68.184.181:8107')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true  # enable SSL/TLS
      #http.cert =OpenSSL::X509::Certificate.ne(File.read("D:/111/client.crt"))
      #http.key =OpenSSL::PKey::RSA.new((File.read("D:/111/client.key")), "123456")# key and password
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE #这个也很重要

      http.post(uri.path, message_wrapper.to_json) {|response|
          print response.body
      }


    end
  end
end
