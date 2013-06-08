class Accident < ActiveRecord::Base
  attr_accessible :chejiaohao_sousun, :chengbao_jine, :chuli_fangshi, :chuxian_jingguo, :chuxian_riqi, :duifang_baoxian, :gusun_jine, :pengzhuang_buwei, :renshang_qingkuang, :sunshi_leixing, :tingche_city_id, :tingche_more, :tingche_provice_id, :zeren_rending
  belongs_to :car
end
