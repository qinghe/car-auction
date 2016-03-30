
class AddActionHistory < ActiveRecord::Migration

  def change
    #mainly for pingan api history
    create_table :action_histories do |t|
      t.column :api_name, :string
      t.column :api_params, :string
      t.column :api_result, :string
      t.references :auction
      t.references :user
      t.timestamps null:false
    end
  end

end
