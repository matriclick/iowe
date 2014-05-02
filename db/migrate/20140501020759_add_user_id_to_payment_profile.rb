class AddUserIdToPaymentProfile < ActiveRecord::Migration
  def change
    add_column :payment_profiles, :user_id, :integer
  end
end
