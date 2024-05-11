class AddInvitationTokenToPlans < ActiveRecord::Migration[7.1]
  def change
    add_column :plans, :invitation_token, :string
    add_index :plans, :invitation_token, unique: true
  end
end
