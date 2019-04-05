class AddWalksToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :season_walks, :integer
    add_column :players, :game_walks, :integer
  end
end
