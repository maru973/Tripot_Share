class AddColumnSpots < ActiveRecord::Migration[7.1]
  def change
    add_column :spots, :opening_hours, :string
    add_column :spots, :phone_number, :integer
    add_column :spots, :website, :string
  end
end
