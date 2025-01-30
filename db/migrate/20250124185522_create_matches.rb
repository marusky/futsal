class CreateMatches < ActiveRecord::Migration[8.0]
  def change
    create_table :matches do |t|
      t.references :game, null: false, foreign_key: true
      t.references :team_1, null: false, foreign_key: { to_table: :teams }
      t.references :team_2, null: false, foreign_key: { to_table: :teams }
      t.integer :goals_team_1, null: false, default: 0
      t.integer :goals_team_2, null: false, default: 0

      t.timestamps
    end
  end
end
