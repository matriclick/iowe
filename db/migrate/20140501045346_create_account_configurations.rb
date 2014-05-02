class CreateAccountConfigurations < ActiveRecord::Migration
  def change
    create_table :account_configurations do |t|
      t.integer :user_id
      t.boolean :allow_netting
      t.integer :collection_mail_frecuency_in_days

      t.timestamps
    end
  end
end
