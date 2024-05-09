class AddInvitedPlanIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :invited_plan_id, :integer
  end
end
