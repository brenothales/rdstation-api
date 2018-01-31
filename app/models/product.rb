class Product < ApplicationRecord
  belongs_to :company

  validates :name, :price, presence: true

end
