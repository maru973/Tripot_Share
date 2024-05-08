class AddOwnerIdToPlans < ActiveRecord::Migration[7.1]
  def change
    add_column :plans, :owner_id, :integer, null: false
    add_foreign_key :plans, :users, column: :owner_id
  end
end
