class RenamePositionColumnToPlannedspots < ActiveRecord::Migration[7.1]
  def change
    rename_column :planned_spots, :position, :row_order
  end
end
