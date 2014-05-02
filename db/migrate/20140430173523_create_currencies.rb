class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :symbol
      t.decimal :fx_rate

      t.timestamps
    end
  end
end
