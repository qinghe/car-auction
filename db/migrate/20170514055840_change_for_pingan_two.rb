# encoding: utf-8
class ChangeForPinganTwo < ActiveRecord::Migration
  #                                         所在表                                         添加列
  #transferBail  String  是  过户保证金  金额，不可为负数，单位：人民币元。当isEntrust为1-委托拍卖时，不可为空。
  #payOutType  String  是  赔付方式  1：赔付实际价值减去过户保证金,2：赔付实际价值减去拍卖款,3：赔付实际价值（后续追偿拍卖款）,99：其他

  #isPayFirstPrice    String    否    首款是否支付
  #firstPricePayDate    String    是    首款支付时间
  #premiumPrice    String    否    溢价金额
  #isPayPremium    String    否    溢价是否支付
  #premiumPayDate    String    是    溢价支付时间
  #competeNum    String    否    参拍人数
  #preservationUser    String    否    保全人员
  #preservationDate    String    否    保全时间
  #preservationDesc    String    否    保全说明
  #documentGroupId    String    否    附件组ID

  # isPayTransferBail String 否 过户保证金是否支付
  # transferBailPayDate String 否 过户保证金支付时间
  # documentGroupId String 否 附件组ID

  def change
    #委托拍卖接口（平安---拍卖公司系统）：增加‘过户保证金’ 、‘赔付方式’
    #add_column :auctions, :transfer_bail, :integer, null: false, default: 0
    add_column :auctions, :pay_out_type, :string, length: 12, null:false, default:''

    #拍卖结果（拍卖公司系统---平安）：增加“首款是否支付”、“首款支付时间” “溢价金额”、‘溢价是否支付’‘溢价支付时间’‘参拍人数’‘保全人员’‘保全时间’‘保全说明；
    add_column :auctions, :is_pay_first_price, :boolean, null:false, default:false
    add_column :auctions, :first_price_pay_date, :datetime
    add_column :auctions, :premium_price, :integer, null: false, default: 0
    add_column :auctions, :is_pay_premium, :boolean, null:false, default:false
    add_column :auctions, :premium_pay_date, :datetime
    add_column :auctions, :preservation_user, :string, length: 128, null:false, default:''
    add_column :auctions, :preservation_date, :datetime
    add_column :auctions, :preservation_desc, :string, length: 1024, null:false, default:''
    add_column :auctions, :document_group_id, :string, length: 128, null:false, default:''

    #过户信息（拍卖公司系统---平安）：增加“过户保证金是否支付” “过户保证金支付时间”2个字段；
    #add_column :auctions, :is_pay_transfer_bail, :boolean, null:false, default:false
    add_column :auctions, :transfer_bail_pay_date, :datetime

  end

end
