class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.date :start_date, null: false, default: nil
      t.date :end_date, null: false, default: nil

      t.timestamps
    end
  end
end
