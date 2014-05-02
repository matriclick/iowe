class AddTokenToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :token, :string
  end
end
