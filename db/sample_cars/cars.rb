# encoding: utf-8
#车辆型号  捷达 1.6 MT   初次登记日期  2011-08-15  过户时效  45天
#户籍所在地   辽宁省-沈阳市   车辆所在地   辽宁省-沈阳市   登记证书  有
#排量  1.6   档位  4WD   购置税   有
#车牌  有   钥匙  有   违章  未确定
#咨询电话  18661770062,18561398597,18561398596,18669850072
#车辆备注  已经完全拆检；钥匙一把；无抵押；有1000服务费和5000的费用需由中标方承担；国四排放标准；其他信息以照片为准；请客户谨慎出价。


#拍卖厅：  倒计时出价大厅 开始：2013-06-14 10:00:00
#距开始：  0天13小时42分36秒  结束：2013-06-14 10:13:00
#拍卖权限  您没有参与拍卖权限   >>点击申请参与拍卖
#起拍价： ￥13000元  加价幅度：￥1000元 保留价：有
#拍卖保证金：￥5000元  车辆承保金：￥90000元 过户保证金：中标价的10%(最低5000元，最高30000元)
publisher_ids = User.where(:role=>'insurance').collect(&:id) 
evaluator_ids = User.where(:role=>'evaluator').collect(&:id) 
car_model_ids = CarModel.leaves.collect(&:id)
prices = (3000..50000).collect{|i| i}

start_times = 50.times.collect{|i|Time.now-5.day+i.day}

cars = [
  { :model_id=>car_model_ids.sample,
    :variator=>0, :displacement =>'1.6', 
    :registered_at=>'2013-06-12',
    :auctioneer=>1,
    :plate_number=>123456,
    :engine_number=>123456,
    :frame_number=>123456,
    :publisher_id=>publisher_ids.sample,
    :evaluator_id=>evaluator_ids.sample,
    "chengbao_jine"=>"", "gusun_jine"=>"",
    :accident_attributes=>{
      "sunshi_leixing"=>"损失类型1",
      "guohu_shixiao"=>45, 
      :tingche_province_id=>6, :tingche_city_id=>38, :tingche_more=>"",
      :huji_province_id=>1, :huji_city_id=>1, :huji_more=>"",
      :gouzhi_shui=>true, 
      :chepai=>true, :yaoshi=>true, :weizhang=>'',
      :cheliang_beizhu=>"已经完全拆检；钥匙一把；无抵押；有1000服务费和5000的费用需由中标方承担；国四排放标准；其他信息以照片为准；请客户谨慎出价。",
      "chejiaohao_sousun"=>"1", "zeren_rending"=>"1", "duifang_baoxian"=>"", "renshang_qingkuang"=>"0", "pengzhuang_buwei"=>["0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"], 
      "chuxian_riqi(1i)"=>"2013", "chuxian_riqi(2i)"=>"6", "chuxian_riqi(3i)"=>"13", "chuxian_riqi"=>"0", 
      "chuxian_jingguo"=>""
    },   
    :auction_attributes=>{:title=>"上海大众-POLO劲情-POLO劲情 1.4 MT", :description=>"some description",
     :hall=>0,:system=>0, :owner_id => 2,
     :start_at=>(Time.now-1.hour).to_s(:db),:expired_at=>(Time.now-40.minute).to_s(:db),
     :starting_price=>13000, :price_increment=>1000, :reserve_price=>14000     
    }  
  },
  { :model_id=>car_model_ids.sample,#opened
    :variator=>0, :displacement =>'1.6', 
    :registered_at=>'2013-06-12',
    :auctioneer=>1,
    :plate_number=>123456,
    :engine_number=>123456,
    :frame_number=>123456,
    :publisher_id=>publisher_ids.sample,
    :evaluator_id=>evaluator_ids.sample,
    :chengbao_jine=>"", "gusun_jine"=>"",
    :accident_attributes=>{
      "sunshi_leixing"=>"损失类型1",
      "guohu_shixiao"=>45, 
      :tingche_province_id=>6, :tingche_city_id=>38, :tingche_more=>"",
      :huji_province_id=>1, :huji_city_id=>1, :huji_more=>"",
      :gouzhi_shui=>true, 
      :chepai=>true, :yaoshi=>true, :weizhang=>'',
      :cheliang_beizhu=>"已经完全拆检；钥匙一把；无抵押；有1000服务费和5000的费用需由中标方承担；国四排放标准；其他信息以照片为准；请客户谨慎出价。",
      "chejiaohao_sousun"=>"1", "zeren_rending"=>"1", "duifang_baoxian"=>"", "renshang_qingkuang"=>"0", "pengzhuang_buwei"=>["0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"], 
      "chuxian_riqi(1i)"=>"2013", "chuxian_riqi(2i)"=>"6", "chuxian_riqi(3i)"=>"13", "chuxian_riqi"=>"0", 
      "chuxian_jingguo"=>""
    },   
    :auction_attributes=>{:title=>"上海大众-POLO劲情-POLO劲情 1.4 MT", :description=>"some description",
     :hall=>0,:system=>0, :owner_id => 2,
     :start_at=>(Time.now).to_s(:db),:expired_at=>(Time.now+1.hour).to_s(:db),
     :starting_price=>13000, :price_increment=>1000, :reserve_price=>14000     
    }  
  },
  { :model_id=>car_model_ids.sample,#open
    :variator=>0, :displacement =>'1.6', 
    :registered_at=>'2013-06-12',
    :auctioneer=>1,
    :plate_number=>123456,
    :engine_number=>123456,
    :frame_number=>123456,
    :publisher_id=>publisher_ids.sample,
    :evaluator_id=>evaluator_ids.sample,
    "chengbao_jine"=>"", "gusun_jine"=>"",
    :accident_attributes=>{
      "sunshi_leixing"=>"损失类型1",
      "guohu_shixiao"=>45, 
      :tingche_province_id=>6, :tingche_city_id=>38, :tingche_more=>"",
      :huji_province_id=>1, :huji_city_id=>1, :huji_more=>"",
      :gouzhi_shui=>true, 
      :chepai=>true, :yaoshi=>true, :weizhang=>'',
      :cheliang_beizhu=>"已经完全拆检；钥匙一把；无抵押；有1000服务费和5000的费用需由中标方承担；国四排放标准；其他信息以照片为准；请客户谨慎出价。",
      "chejiaohao_sousun"=>"1", "zeren_rending"=>"1", "duifang_baoxian"=>"", "renshang_qingkuang"=>"0", "pengzhuang_buwei"=>["0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"], 
      "chuxian_riqi(1i)"=>"2013", "chuxian_riqi(2i)"=>"6", "chuxian_riqi(3i)"=>"13", "chuxian_riqi"=>"0", 
      "chuxian_jingguo"=>""
    },   
    :auction_attributes=>{:title=>"上海大众-POLO劲情-POLO劲情 1.4 MT", :description=>"some description",
     :hall=>0,:system=>0, :owner_id => 2,
     :start_at=>(Time.now+3.hour).to_s(:db),:expired_at=>(Time.now+3.hour+20.minute).to_s(:db),
     :starting_price=>13000, :price_increment=>1000, :reserve_price=>14000     
    }  
  },
  { :model_id=>car_model_ids.sample, #open
    :variator=>0, :displacement =>'1.6', 
    :registered_at=>'2013-06-12',
    :auctioneer=>1,
    :plate_number=>123456,
    :engine_number=>123456,
    :frame_number=>123456,
    :publisher_id=>publisher_ids.sample,
    :evaluator_id=>evaluator_ids.sample,
    "chengbao_jine"=>"", "gusun_jine"=>"",
    :accident_attributes=>{
      "sunshi_leixing"=>"损失类型1",
      "guohu_shixiao"=>45, 
      :tingche_province_id=>6, :tingche_city_id=>38, :tingche_more=>"",
      :huji_province_id=>1, :huji_city_id=>1, :huji_more=>"",
      :gouzhi_shui=>true, 
      :chepai=>true, :yaoshi=>true, :weizhang=>'',
      :cheliang_beizhu=>"已经完全拆检；钥匙一把；无抵押；有1000服务费和5000的费用需由中标方承担；国四排放标准；其他信息以照片为准；请客户谨慎出价。",
      "chejiaohao_sousun"=>"1", "zeren_rending"=>"1", "duifang_baoxian"=>"", "renshang_qingkuang"=>"0", "pengzhuang_buwei"=>["0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"], 
      "chuxian_riqi(1i)"=>"2013", "chuxian_riqi(2i)"=>"6", "chuxian_riqi(3i)"=>"13", "chuxian_riqi"=>"0", 
      "chuxian_jingguo"=>""
    },   
    :auction_attributes=>{:title=>"上海大众-POLO劲情-POLO劲情 1.4 MT", :description=>"some description",
     :hall=>0,:system=>0, :owner_id => 2,
     :start_at=>(Time.now+1.hour).to_s(:db),:expired_at=>(Time.now+1.hour+20.minute).to_s(:db), 
     :starting_price=>13000, :price_increment=>1000, :reserve_price=>14000     
    }  
  }
  
]

10.times{|i|
  cars.each_index{|idx|
    cars[idx][:auction_attributes][:starting_price]=prices.sample
    cars[idx][:auction_attributes][:start_at]=start_times.sample
    cars[idx][:auction_attributes][:expired_at]=cars[idx][:auction_attributes][:start_at]+20.minute
    car = Car.new(cars[idx])
    car.serial_no = ("s%010d" % (i*10+idx))
    car.engine_number = ("e%010d" % i)
    car.plate_number = ("p%010d" % i)
    car.frame_number = ("f%010d" % i)
    car.model_id = car_model_ids.sample
    car.save!  
    #车辆图片
    for file in Dir[File.join(File.dirname(__FILE__),'files', idx.to_s, "a_*.{jpg,gif,png}")]
      open(file) do|f|
        accident_file = car.car_images.build
        accident_file.uploaded = f
        accident_file.save!
      end
    end
  }  
}