
class FixAccidentPosition < ActiveRecord::Migration

  def change
    # default "" would raise error in rails 4.1.x
    change_column_default(:accidents, :pengzhuang_buwei, nil )
  end

end
