module Pingan
  class ClaimGetTokenForIobsMessage < MessageBase
    self.api_path = '/open/appsvr/property/claimGetTokenForIOBS'
    self.required_fields = [ :partnerAccount ]

    #{"ret"=>"0",
    #  "msg"=>"",
    #  "requestId"=>"claimGetTokenForIOBS1495161362",
    #  "data"=>
    #  {"token"=>
    #    "8CJK29FVFY2IK9W0Y8IIdKWD06MI202F:eNPzVnm9-q4y5Il6Frbm-ucmRXI=:eyJzY29wZSI6Imljb3JlLXB0cy1vcGVuYXBpLWRtei1zdGctcHJpIiwiZGVhZGxpbmUiOjE0OTUxNjIyNjJ9",
    #    "resultCode"=>"200",
    #    "resultMessage"=>"成功"}}

    def initialize( auction )
      super
    end

  end
end
