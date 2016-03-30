
class AddToken < ActiveRecord::Migration

  def change
    add_column :users, :access_token, :string
    add_column :users, :token_expires_in, :integer
    add_column :users, :token_expires_at, :datatime
  end

end
