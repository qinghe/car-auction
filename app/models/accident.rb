# encoding: utf-8
class Accident < ActiveRecord::Base
  POSITIONS={            
    '正前方'=>1, '左前方'=>2, '右前方'=>3, '正后方'=>4, '左后方'=>5, '右后方'=>6,
    '正上方'=>7, '底盘'=>8, '右侧中部'=>9, '右侧中部靠前'=>10, '右侧中部靠后'=>11, '左侧中部'=>12,
    '左侧中部靠前'=>13, '左侧中部靠后'=>14 }
  attr_accessible :chejiaohao_sousun, :chengbao_jine, :chuli_fangshi, :chuxian_jingguo, :chuxian_riqi, :duifang_baoxian, :gusun_jine, :pengzhuang_buwei, :renshang_qingkuang, :sunshi_leixing, :zeren_rending,
    :tingche_province_id, :tingche_city_id, :tingche_more, 
    :guohu_shixiao, :huji_province_id, :huji_city_id, :huji_more,
    :gouzhi_shui, :chepai, :yaoshi, 
    :weizhang, :cheliang_beizhu
  belongs_to :car  
  serialize :pengzhuang_buwei, Array
  
  
  def huji_address
    if huji_province_id>0 and huji_city_id>0
      "#{ChineseCities::Province.find(huji_province_id).name}#{ChineseCities::City.find(huji_city_id).name}"
    end
  end
  def tingche_address
    if tingche_province_id>0 and tingche_city_id>0
      "#{ChineseCities::Province.find(tingche_province_id).name}#{ChineseCities::City.find(tingche_city_id).name}"
    end    
  end
  
end
