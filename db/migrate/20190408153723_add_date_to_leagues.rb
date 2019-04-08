class AddDateToLeagues < ActiveRecord::Migration[5.2]
  def change
    add_column :leagues, :date_of_games, :date
  end
end
