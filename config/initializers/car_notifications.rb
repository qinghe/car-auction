#ActiveSupport::Notifications.subscribe "dlhc.car.evaluated" do |*args|
#  event = ActiveSupport::Notifications::Event.new *args
#  # event.name      # => "process_action.action_controller"
#  # event.duration  # => 10 (in milliseconds)
#     # => {:extra=>information}
#  car =  event.payload[:car]
#  Rails.logger.debug "car.evaluated #{car.inspect} #{ event.payload }"
#  if car.publisher_pingan_pusher?
#    msg = Pingan::QuotedPriceMessage.new( car.auction )
#    msg.post
#  end
#end


ActiveSupport::Notifications.subscribe "pingan.event" do |*args|
  event = ActiveSupport::Notifications::Event.new *args
  # payload: { task: @task,  message_parser: message_parser, result: @result }
  task =  event.payload[:task]
  #Rails.logger.debug "pingan.event #{ event.payload }"
  #pingan.event {:task=>"sendCarInquireInfo", :message_parser=>#<Pingan::CarInquireInfoParser:0x0000000370f2d0 @data="{    \"partnerAccount\":\"\",    \"taskAuctionNo\":\"taskAuctionNo\",    \"modelName\":\"\",    \"location\":\"\",    \"registerDate\":\"\",    \"gearboxStatus\":\"\",    \"engineStatus\":\"\",    \"carMark\":\"\",    \"reportDate\":\"\",    \"carBelongKindName\":\"\",    \"hasScuttle\":\"\",    \"isTeardown\":\"\",    \"robberyCar\":\"\",    \"completeFormalities\":\"\",    \"frameDamage\":\"\",    \"isMortgage\":\"\",    \"secondAccident\":\"\",    \"secondHand\":\"\",    \"isLoan\":\"\",    \"gear\":\"\",    \"rackNo\":\"\",    \"insuredValue\":\"\",    \"otherFee\":\"\",    \"actualValue\":\"\",    \"inquireStartDate\":\"\",    \"inquireEndDate\":\"\",    \"surveyUserId\":\"\",    \"estimateLoss\":\"\",    \"url\":\"\",    \"remark\":\"\"}", @attributes={"partnerAccount"=>"", "taskAuctionNo"=>"taskAuctionNo", "modelName"=>"", "location"=>"", "registerDate"=>"", "gearboxStatus"=>"", "engineStatus"=>"", "carMark"=>"", "reportDate"=>"", "carBelongKindName"=>"", "hasScuttle"=>"", "isTeardown"=>"", "robberyCar"=>"", "completeFormalities"=>"", "frameDamage"=>"", "isMortgage"=>"", "secondAccident"=>"", "secondHand"=>"", "isLoan"=>"", "gear"=>"", "rackNo"=>"", "insuredValue"=>"", "otherFee"=>"", "actualValue"=>"", "inquireStartDate"=>"", "inquireEndDate"=>"", "surveyUserId"=>"", "estimateLoss"=>"", "url"=>"", "remark"=>""}, @task_auction=#<Auction id: 120, private: false, delta: false, status: 0, budget_id: 0, owner_id: 0, won_offer_id: nil, title: "", description: "", highlight: false, expired_at: nil, offers_count: 0, visits: 0, created_at: "2016-08-12 08:18:10", updated_at: "2016-08-22 06:46:03", rating: 0.0, auctioneer_id: 1, car_id: 120, expected_start_at: nil, expected_expired_at: nil, public_start_at: nil, public_expired_at: nil, start_at: nil, starting_price: 0.0, price_increment: 0.0, reserve_price: 0.0, deposit: 5000.0, system: 0, hall: 0, serial_no: "taskAuctionNo", location: nil, type_name: nil, is_pass: nil, pass_times: nil, commissioned_time: nil, transfer_complete: nil, transfer_request_time: nil, transfer_real_time: nil, remark: nil, last_api_name: nil, last_api_succeed: nil, last_api_message: nil, inquire_amount: nil, bidding_user: nil, is_entrust: nil, apply_reason: "just a test", inquire_result: nil, inquire_opinion: nil, feedback_result: nil, feedback_opinion: nil, is_auction: false, transfer_bail: #<BigDecimal:16e4cf8,'0.0',9(27)>, is_pay_transfer_bail: false, is_pay_auction_price: false, transfer_opinion: nil, channel_transfer_result: nil, channel_transfer_opinion: nil>>, :result=>nil}
  if task == "sendCarInquireInfo"
    #ChinaSMS.use :w371, :username=>'dlhc_ad',:password=>'dlhc_ad'
    #result = ChinaSMS.to cellphone, send_string.encode('gb2312')
  end
end
