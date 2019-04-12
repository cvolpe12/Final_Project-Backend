class AddIsExtraPlayerToDraft < ActiveRecord::Migration[5.2]
  def change
    add_column :drafts, :extra_player, :boolean
  end
end
