
class AddAuctionImages < ActiveRecord::Migration

  def change

    #平安与拍卖对接方案170706修改，添加 document_id_list
    add_column :cars, :document_id_list, :string, limit: 1024

  end

end
