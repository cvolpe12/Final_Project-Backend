class CreateLeagues < ActiveRecord::Migration[5.2]
  def change
    create_table :leagues do |t|
      t.string :name
      t.integer :participants
      t.integer :limit
      t.string :player_source

      t.timestamps
    end
  end
end
