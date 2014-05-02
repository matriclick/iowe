class CreatePaymentProfiles < ActiveRecord::Migration
  def change
    create_table :payment_profiles do |t|
      t.string :bank_name
      t.string :account_number
      t.string :account_type
      t.string :rut

      t.timestamps
    end
  end
end
