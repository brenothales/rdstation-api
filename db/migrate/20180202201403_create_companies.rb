class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :cnpj
      t.string :country
      t.integer :currency
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
