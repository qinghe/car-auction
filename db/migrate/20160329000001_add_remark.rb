
class AddRemark < ActiveRecord::Migration

  def change
    add_column :cars, :remark, :string
  end

end
