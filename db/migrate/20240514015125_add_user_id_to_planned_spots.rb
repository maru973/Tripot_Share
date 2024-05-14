class AddUserIdToPlannedSpots < ActiveRecord::Migration[7.1]
  def change
    add_reference :planned_spots, :user, foreign_key: true
  end
end
