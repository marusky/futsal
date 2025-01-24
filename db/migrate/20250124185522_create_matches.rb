class CreateMatches < ActiveRecord::Migration[8.0]
  def change
    create_table :matches do |t|
      t.references :game, null: false, foreign_key: true
      t.references :team_1, null: false, foreign_key: true
      t.references :team_2, null: false, foreign_key: true

      t.timestamps
    end
  end
end
