class AddUserIdToPlannedSpots < ActiveRecord::Migration[7.1]
  def change
    add_reference :planned_spots, :user, null: false, foreign_key: true
  end
end
