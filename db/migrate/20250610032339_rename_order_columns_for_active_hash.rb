class RenameOrderColumnsForActiveHash < ActiveRecord::Migration[7.1]
  def change
    rename_column :orders, :usage, :usage_id
    rename_column :orders, :color, :color_tone_id
    rename_column :orders, :atmosphere, :mood_id
  end
end