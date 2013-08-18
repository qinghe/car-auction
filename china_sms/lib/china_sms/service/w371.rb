# encoding: utf-8
module ChinaSMS
  module Service
    module W371
      extend self
      #http://sms2.371.com/default.asp 这个是网关登陆的链接
      # ChinaSMS.use :w371, :username=>'are22',:password=>'are22'
      # ChinaSMS.to '13889611691','just a test'
      # => {:success=>true, :code=>"0", :message=>"短信发送成功"} 
      URL = "http://sms2.371.com/mingnet.asp"
      MESSAGES = {
        '0'  => '短信发送成功',
        '1' => '内容违规',
        '2' => '内容过长',
        '3' => '用户或密码错误码或禁止',
        '4' => '余额不足',
        '5' => '号码不能为空'       
      }

      def to(phone, content, options)
        phones = Array(phone).join(';')
        uri = URI(URL)
        params = {:username=> options[:username], :pwd=> options[:password], :tel=> phones, :content=> content}
        uri.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(uri)
        result res.body
      end

      def result(code)
        {
          success: (code == '0'),
          code: code,
          message: MESSAGES[code]
        }
      end
    end
  end
end
