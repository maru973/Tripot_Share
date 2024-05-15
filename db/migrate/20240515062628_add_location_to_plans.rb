class AddLocationToPlans < ActiveRecord::Migration[7.1]
  def change
    add_column :plans, :location, :string, null: false
    add_column :plans, :address, :string, null: false
    add_column :plans, :latitude, :float, null: false
    add_column :plans, :longitude, :float, null: false
  end
end
