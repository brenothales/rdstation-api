class CreateSubscribers < ActiveRecord::Migration[5.1]
  def change
    create_table :subscribers do |t|
      t.integer :manager_id
      t.integer :payer_id
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
