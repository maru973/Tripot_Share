class CreatePlannedSpots < ActiveRecord::Migration[7.1]
  def change
    create_table :planned_spots do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :spot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
