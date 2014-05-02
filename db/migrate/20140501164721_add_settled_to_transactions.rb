class AddSettledToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :settled_lender, :boolean
    add_column :transactions, :settled_debtor, :boolean
  end
end
