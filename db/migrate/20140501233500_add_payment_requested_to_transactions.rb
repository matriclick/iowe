class AddPaymentRequestedToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :payment_requested, :boolean
  end
end
