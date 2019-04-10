class AddEnteredInTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :entered, :boolean
  end
end
