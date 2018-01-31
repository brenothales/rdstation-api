class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :cnpj
      t.string :country
      t.integer :currency

      t.timestamps
    end
  end
end
