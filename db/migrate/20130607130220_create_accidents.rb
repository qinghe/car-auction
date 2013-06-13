# encoding: utf-8
class CreateAccidents < ActiveRecord::Migration
  def self.up
    create_table :accidents do |t|
      t.integer :car_id
      t.integer :sunshi_leixing
      t.date :chuxian_riqi
      t.integer :tingche_provice_id #停车地点
      t.integer :tingche_city_id
      t.string :tingche_more
      t.integer :huji_provice_id    #车辆户籍地点
      t.integer :huji_city_id
      t.string :huji_more
      t.boolean :chejiaohao_sousun
      t.integer :zeren_rending
      t.string :duifang_baoxian
      t.integer :renshang_qingkuang
      t.string :pengzhuang_buwei, :default=>''
      t.string :chuxian_jingguo
      t.integer :chengbao_jine
      t.integer :gusun_jine
      t.integer :chuli_fangshi # 处理方式(委托拍卖，询问底价)
      t.integer :guohu_shixiao # n天 过户时效 
      t.integer :dengji_zhengshu #登记证书
      t.integer :xingche_zheng   #行车证
      t.integer :gouzhi_shui     #购置税
      t.integer :chepai          #车牌
      t.integer :yaoshi          #钥匙
      t.boolean :weituo_xieyi #委托协议
      t.boolean :youwu_diya   # 有无抵押
      t.boolean :youwu_qita   #有无其他费用
      t.timestamps
    end
  end
  def self.down
    drop_table :accidents
  end
end
