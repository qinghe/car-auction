require 'uri'
require 'net/http'
require 'openssl'
def post( xml )

    uri = URI.parse('https://localhost:3000/InsCarQuo/PingAn')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true  # enable SSL/TLS
    #http.cert =OpenSSL::X509::Certificate.ne(File.read("D:/111/client.crt"))
    #http.key =OpenSSL::PKey::RSA.new((File.read("D:/111/client.key")), "123456")# key and password
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE #这个也很重要

    http.request_post(uri.path, xml) {|response|
      print "request:"+xml
      print "response: "+response.body
    }


end

#=================== pingan task ===============================
#ENV['PINGAN_TASK']
pingan_task = ARGV.first
raise "please pass params as pingan_task" if pingan_task.nil?

file = "spec/fixtures/pingan/#{pingan_task}.xml"
xml = File.read( file )

post( xml )
