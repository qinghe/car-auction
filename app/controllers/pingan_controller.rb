class PinganController < ApplicationController
  skip_before_filter :authenticate
  skip_before_action :verify_authenticity_token

  #taskAuctionNo String 否 拍卖编号
  #modelName String 否 车型                  car.model_title                 Y
  #location String 否 所在地                 accident.huji_more             Y
  #registerDate Date 否 登记日期             car.registered_at              Y
  #gearboxStatus String 否 变速箱            N                                        car.gearbox_status
  #engineStatus String 否 发动机             N                                        car.engine_status
  #carMark String 否 车牌号                  car.plate_number               Y
  #reportDate Date 否 出险日期               accident.chuxian_riqi          Y
  #carBelongKindName String 否 车辆性质              N                                car.car_belong_kind_name
  #hasScuttle String 否 天窗                        N                                car.has_scuttle
  #isTeardown String 否 是否拆解             accident.shifou_caijian bool   Y
  #robberyCar String 否 盗抢车                       N                                car.robbery_car
  #completeFormalities String 否 手续齐全            N                                car.complete_formalities
  #frameDamage String 否 车架号损坏          accident.chejiaohao_sousun bool Y
  #isMortgage String 否 是否抵押             accident.youwu_diya bool        Y
  #secondAccident String 否 二次事故                 N                                car.second_accident
  #secondHand String 否 是否二手车                   N                                car.second_hand
  #isLoan String 否 是否贷款                         N                                car.is_loan
  #gear String 否 手动、自动                car.variator int                          car.gear
  #rackNo String 否 车架号                 car.frame_number
  #insuredValue BigDecimal 否 保险金额     car.chengbao_jine
  #otherFee BigDecimal 否 其他费用                   N                                accident.other_fee
  #actualValue BigDecimal 否 实际价值      car.shiji_jiazhi
  #inquireStartDate Date 否 询价日期       auction.expected_start_at
  #inquireEndDate Date 否 询价结束日期      auction.expected_expired_at
  #surveyUserId String 否 查勘员           car.evaluator_id int
  #estimateLoss BigDecimal 否 定损金额      accident.zuizhong_peifu_jine 最终赔付金额?
  #remark String 否 备注
  def sink
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

    @task = params[:task]

    message =  request.body.read
    message_parser = case @task
      when 'sendCarInquireInfo'
        Pingan::CarInquireInfoParser.new( message )
      when 'sendHighestBiddingInfo'
        Pingan::BiddingInfoParser.new( message )
      when 'receiveAuction'
        Pingan::EntrustedMessageParser.new( message )
      when 'multiInquireFeedback'
        Pingan::MultiInquireFeedbackHandler.new( message )
      when 'receiveAuctionCheck'
        Pingan::AuctionResultCheckHandler.new( message )
      when 'receiveTransferInfoCheck'
        Pingan::TransferInfoCheckParser.new( message )

    end

      ActiveSupport::Notifications.instrument( 'pingan.event', { task: @task,  message_parser: message_parser, result: @result } ) do
        @result = message_parser.perform
        if @result.succeed
          if @task == 'sendCarInquireInfo'
            auction = message_parser.created_car.auction
            #取得图片信息
            parsed_result = Pingan::InquireCarImageUrlMessage.new( auction ).post
            Pingan::InquireCarImageUrlMessageHandler.new( auction, parsed_result ).perform

          end
        end
      end

    respond_to do |format|
      format.json  { render :json => @result }
    end
  end

end
