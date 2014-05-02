class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :debtor_id
      t.integer :lender_id
      t.decimal :amount
      t.integer :currency_id
      t.text :comments

      t.timestamps
    end
  end
end
