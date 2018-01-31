class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
