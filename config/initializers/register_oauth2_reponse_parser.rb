OAuth2::Response.register_parser(:pingan_oauth2, []) do |body|
  #{"ret":"0","data":{"expires_in":"43199","openid":"P_DLHC_CLAIM00","access_token":"C32D6F49CF9B4292839FDAC1CC36E79C"},"msg":""}
  hash = MultiJson.load(body)
  hash['data']
end
