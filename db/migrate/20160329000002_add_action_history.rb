
class AddActionHistory < ActiveRecord::Migration

  def change
    #mainly for pingan api history
    create_table :action_histories do |t|
      t.column :api_name, :string   # 255 by default
      t.column :api_params, :text   # it is utf-8
      t.column :api_result, :text   # 255 by default
      t.references :auction
      t.references :user
      t.timestamps null:false
    end
  end

end
