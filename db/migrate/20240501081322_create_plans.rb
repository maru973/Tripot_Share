class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
