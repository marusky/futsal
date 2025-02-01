class CreateAppearances < ActiveRecord::Migration[8.0]
  def change
    create_table :appearances do |t|
      t.references :player, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.integer :goals, null: false, default: 0

      t.timestamps
    end
  end
end
