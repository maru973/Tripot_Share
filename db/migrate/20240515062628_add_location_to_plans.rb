class AddLocationToPlans < ActiveRecord::Migration[7.1]
  def change
    add_column :plans, :location, :string, null: false
  end
end
