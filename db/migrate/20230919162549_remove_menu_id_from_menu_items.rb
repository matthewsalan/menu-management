class RemoveMenuIdFromMenuItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :menu_items, :menu_id, :integer
  end
end
