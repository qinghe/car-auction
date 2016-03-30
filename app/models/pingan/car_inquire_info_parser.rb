module Pingan
  class CarInquireInfoParser < MessageParser

    #attr_accessor :taskAuctionNo, :modelName

    def perform
      #taskAuctionNo String 否 拍卖编号           N   auction.no
      #modelName String 否 车型                car.model_title                 Y
      #location String 否 所在地                accident.huji_more             Y
      #registerDate Date 否 登记日期             car.registered_at              Y
      #gearboxStatus String 否 变速箱            N   car.gearbox_status
      #engineStatus String 否 发动机             N   car.engine_status
      #carMark String 否 车牌号                  car.plate_number               Y
      #reportDate Date 否 出险日期               accident.chuxian_riqi          Y
      #carBelongKindName String 否 车辆性质       N   car.car_belong_kind_name
      #hasScuttle String 否 天窗                N   car.has_scuttle
      #isTeardown String 否 是否拆解             accident.shifou_caijian bool   Y
      #robberyCar String 否 盗抢车               N   car.robbery_car
      #completeFormalities String 否 手续齐全     N   car.complete_formalities
      #frameDamage String 否 车架号损坏          accident.chejiaohao_sousun bool Y
      #isMortgage String 否 是否抵押             accident.youwu_diya bool        Y
      #secondAccident String 否 二次事故          N   car.second_accident
      #secondHand String 否 是否二手车             N   car.second_hand
      #isLoan String 否 是否贷款                  N   car.is_loan
      #gear String 否 手动、自动                car.variator int       car.gear_name
      #rackNo String 否 车架号                 car.frame_number
      #insuredValue BigDecimal 否 保险金额     car.chengbao_jine
      #otherFee BigDecimal 否 其他费用            N   accident.other_fee
      #actualValue BigDecimal 否 实际价值      car.shiji_jiazhi
      #inquireStartDate Date 否 询价日期       auction.expected_start_at
      #inquireEndDate Date 否 询价结束日期      auction.expected_expired_at
      #surveyUserId String 否 查勘员            N car.survey_user
      #estimateLoss BigDecimal 否 定损金额      car.gusun_jine 最终赔付金额?
      #remark String 否 备注                   accident.cheliang_beizhu

      #{
      #    "partnerAccount":"",
      #    "taskAuctionNo":"",
      #    "modelName":"",
      #    "location":"",
      #    "registerDate":"",
      #    "gearboxStatus":"",
      #    "engineStatus":"",
      #    "carMark":"",
      #    "reportDate":"",
      #    "carBelongKindName":"",
      #    "hasScuttle":"",
      #    "isTeardown":"",
      #    "robberyCar":"",
      #    "completeFormalities":"",
      #    "frameDamage":"",
      #    "isMortgage":"",
      #    "secondAccident":"",
      #    "secondHand":"",
      #    "isLoan":"",
      #    "gear":"",
      #    "rackNo":"",
      #    "insuredValue":"",
      #    "otherFee":"",
      #    "actualValue":"",
      #    "inquireStartDate":"",
      #    "inquireEndDate":"",
      #    "surveyUserId":"",
      #    "estimateLoss":"",
      #    "url":"", # photo, comma seperated
      #    "remark":""
      #}
Rails.logger.debug " attributes = #{attributes}"
      attrs = attributes
      car_params = {
        serial_no: attrs['taskAuctionNo'],
        model_title: attrs['modelName'],
        registered_at: attrs['registerDate'],
        gearbox_status: attrs['gearboxStatus'],
        engine_status:  attrs['engineStatus'],
        plate_number: attrs['carMark'],
        car_belong_kind_name: attrs['carBelongKindName'],
        has_scuttle:  attrs['hasScuttle'],
        robbery_car:  attrs['robberyCar'],
        complete_formalities:  attrs['completeFormalities'],
        second_accident:  attrs['secondAccident'],
        second_hand:  attrs['secondHand'],
        is_loan:  attrs['isLoan'],
        gear_name:  attrs['gear'],
        frame_number:  attrs['rackNo'],
        chengbao_jine:  attrs['insuredValue'],
        frame_number:  attrs['rackNo'],
        shiji_jiazhi:  attrs['actualValue'],
        survey_user:  attrs['surveyUserId'],
        gusun_jine: attrs['estimateLoss'],
        url: attrs['url']
        }
      accident_params = { tingche_more: attrs['location'],
        chuxian_riqi: attrs['reportDate'],
        shifou_caijian:  attrs['isTeardown'],
        chejiaohao_sousun: attrs['frameDamage'],
        youwu_diya: attrs['isMortgage'],
        other_fee: attrs['otherFee'],
        cheliang_beizhu: attrs['remark']
        }
      auction_params = { serial_no: attrs['taskAuctionNo'],
        expected_start_at:  attrs['inquireStartDate'],
        expected_expired_at:  attrs['inquireEndDate'],
        }
      result = BoolMessageWrapper.new( false )
      car = AccidentCar.new( car_params )
      car.build_accident( accident_params )
      car.build_auction( auction_params )

      car.publisher = User.pingan_pusher

      result.succeed = car.save
      touch_history!( self,  result )

      result
    end

    def xpath
      "REQUEST/*"
    end
  end

end
