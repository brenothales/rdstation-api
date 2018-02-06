class AddFieldsToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :description, :text
    add_column :companies, :primary_color, :string
    add_column :companies, :enable, :boolean
  end
end
