class AddUserIdToPlannedSpots < ActiveRecord::Migration[7.1]
  def change
    add_column :planned_spots, :user_id, :integer
  end
end
