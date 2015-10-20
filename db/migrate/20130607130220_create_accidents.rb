# encoding: utf-8
class CreateAccidents < ActiveRecord::Migration
  def self.up
    create_table :accidents do |t|
      t.integer :car_id
      t.integer :sunshi_leixing                  #损失类型
      t.date :chuxian_riqi                       #出险日期  
      t.integer :shifou_caijian
      t.integer :tingche_province_id,:default=>0 #停车地点
      t.integer :tingche_city_id,:default=>0
      t.string :tingche_more                     #停车more
      t.integer :huji_province_id,:default=>0    #车辆户籍地点
      t.integer :huji_city_id,:default=>0
      t.string :huji_more                        #户籍more
      t.boolean :chejiaohao_sousun
      t.integer :zeren_rending
      t.string :duifang_baoxian
      t.integer :renshang_qingkuang
      t.string :pengzhuang_buwei, :default=>''  #碰撞部位
      t.string :chuxian_jingguo                 #出险经过
      t.float :zuizhong_peifu_jine,:default=>0  #最终赔付金额
      t.integer :chuli_fangshi,:default=>0 # 处理方式(委托拍卖，询问底价)
      t.integer :guohu_shixiao,:default=>0 # n天 过户时效 
      t.integer :dengji_zhengshu,:default=>0 #登记证书
      t.integer :xingche_zheng,:default=>0   #行车证
      t.integer :gouzhi_shui,:default=>0   #购置税
      t.integer :chepai,:default=>0       #车牌
      t.integer :yaoshi,:default=>0       #钥匙
      t.boolean :weituo_xieyi,:default=>false #委托协议
      t.boolean :youwu_diya,:default=>false   # 有无抵押
      t.boolean :youwu_qita,:default=>false  #有无其他费用
      t.string  :weizhang   #违章
      t.string :cheliang_beizhu, :length=>1024 #车辆备注
      t.timestamps
    end
  end
  def self.down
    drop_table :accidents
  end
end
