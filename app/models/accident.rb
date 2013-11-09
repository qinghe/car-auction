# encoding: utf-8
class Accident < ActiveRecord::Base
  attr_accessible :chejiaohao_sousun, :chuli_fangshi,:shifou_caijian, :chuxian_jingguo, :chuxian_riqi, :duifang_baoxian, :gusun_jine, :pengzhuang_buwei, :renshang_qingkuang, :sunshi_leixing, :zeren_rending,
    :tingche_province_id, :tingche_city_id, :tingche_more, 
    :guohu_shixiao, :huji_province_id, :huji_city_id, :huji_more,
    :gouzhi_shui, :chepai, :yaoshi,
    :weituo_xieyi, :youwu_diya, :youwu_qita,
    :dengji_zhengshu, :xingche_zheng,
    :weizhang, :cheliang_beizhu
  belongs_to :car  
  serialize :pengzhuang_buwei, Array

    
  #损失类型
  SUNSHILEIXING = {'A损失类型'=>0,'b损失类型'=>1,'c损失类型'=>2 }
  #是否拆检
  SHIFOUCAIJIAN = {'完全拆检'=>0,'未拆检'=>1 }
  #车架号是否受损
  CHEJIAHAOSHOUSUN = {'是'=>0,'否'=>1 }
  #责任认定
  ZERENRENDING = {'多方事故'=>0,'对方事故'=>1 }
  #人伤情况
  RENSHANGQINGKUANG = {'无伤亡'=>0,'车主死亡'=>1,'车主轻伤'=>2 }
  #碰撞部位
  POSITIONS={
      '正前方'=>1, '左前方'=>2, '右前方'=>3, '正后方'=>4, '左后方'=>5, '右后方'=>6,
      '正上方'=>7, '底盘'=>8, '右侧中部'=>9, '右侧中部靠前'=>10, '右侧中部靠后'=>11, '左侧中部'=>12,
      '左侧中部靠前'=>13, '左侧中部靠后'=>14, '水淹'=> 15, '火烧'=> 16 }

  def huji_address
    if huji_province_id.present? and huji_province_id>0 and huji_city_id.present? and huji_city_id>0
      "#{ChineseCities::Province.find(huji_province_id).name}#{ChineseCities::City.find(huji_city_id).name}"
    end
  end
  def tingche_address
    if tingche_province_id.present? and tingche_province_id>0 and tingche_city_id.present? and tingche_city_id>0
      "#{ChineseCities::Province.find(tingche_province_id).name}#{ChineseCities::City.find(tingche_city_id).name}"
    end    
  end

  def lost_type
    SUNSHILEIXING.key(sunshi_leixing)
  end

  def inspection
    SHIFOUCAIJIAN.key(shifou_caijian)
  end

  def frame_number_lost
  CHEJIAHAOSHOUSUN.key(chejiaohao_sousun)
  end

  def responsibility_cognizance
  ZERENRENDING.key(zeren_rending)
  end

  def injure_condition
    RENSHANGQINGKUANG.key(renshang_qingkuang)
  end

  def hit_position
    positions = pengzhuang_buwei.select{|p|p.to_i > 0}
    positions.inject(""){|hp,p| hp + POSITIONS.key(p.to_i)+", " }
  end
end
