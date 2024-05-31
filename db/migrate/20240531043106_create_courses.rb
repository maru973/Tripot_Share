class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :start_location, null: false
      t.string :end_location, null: false
      t.references :plan, null: false, foreign_key: true
      t.references :planned_spot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
