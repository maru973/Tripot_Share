class AddPositionToPlannedSpots < ActiveRecord::Migration[7.1]
  def change
    add_column :planned_spots, :position, :integer
  end
end
