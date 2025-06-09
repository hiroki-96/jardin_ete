class ChangeNullConstraintsOnSizes < ActiveRecord::Migration[7.1]
  def change
    change_column_null :sizes, :name, true
    change_column_null :sizes, :price, true
  end
end