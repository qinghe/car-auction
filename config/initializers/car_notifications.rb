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
  Rails.logger.debug "pingan.event #{ event.payload }"
  #msg.post

end
