class AddTypeToMatches < ActiveRecord::Migration[8.0]
  def change
    add_column :matches, :type, :string
  end
end
