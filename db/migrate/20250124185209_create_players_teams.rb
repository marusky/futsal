class CreatePlayersTeams < ActiveRecord::Migration[8.0]
  def change
    create_table :players_teams, id: false do |t|
      t.references :player, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.integer :goals

      t.timestamps
    end
  end
end
