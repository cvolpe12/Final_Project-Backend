class ChangeDateToBeStringInLeagues < ActiveRecord::Migration[5.2]
  def change
    change_column :leagues, :date_of_games, :string
  end
end
