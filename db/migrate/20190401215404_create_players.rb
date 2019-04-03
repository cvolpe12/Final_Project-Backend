class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.text :first_name
      t.text :last_name
      t.text :team
      t.text :position
      t.text :batting_stance

      t.decimal :season_batting_avg
      t.decimal :season_slugging_pct
      t.integer :season_hits
      t.integer :season_doubles
      t.integer :season_triples
      t.integer :season_home_runs
      t.integer :season_runs
      t.integer :season_rbi

      t.decimal :game_batting_avg
      t.decimal :game_slugging_pct
      t.integer :game_hits
      t.integer :game_doubles
      t.integer :game_triples
      t.integer :game_home_runs
      t.integer :game_runs
      t.integer :game_rbi




      t.timestamps
    end
  end
end
