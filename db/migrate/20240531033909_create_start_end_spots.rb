class CreateStartEndSpots < ActiveRecord::Migration[7.1]
  def change
    create_table :start_end_spots do |t|
      t.string :start_spot, null: false
      t.string :end_spot, null: false
      t.references :plan, null: false, foreign_key: true
      t.references :planned_spot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
