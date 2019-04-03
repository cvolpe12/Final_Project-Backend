class AddRbiToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :season_rbi, :integer
    add_column :players, :game_rbi, :integer
  end
end
