class AddPlaceIdToSpots < ActiveRecord::Migration[7.1]
  def change
    add_column :spots, :place_id, :string
    add_index :spots, :place_id, unique: true
  end
end
