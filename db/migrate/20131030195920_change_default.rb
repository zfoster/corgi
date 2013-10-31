class ChangeDefault < ActiveRecord::Migration
  def change
    change_column_default :events, :price, nil
  end
end
