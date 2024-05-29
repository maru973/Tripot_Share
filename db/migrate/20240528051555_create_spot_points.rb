class CreateSpotPoints < ActiveRecord::Migration[7.1]
  def change
    create_table :spot_points do |t|
      t.integer :point, null: false, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :planned_spot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
