class Company < ApplicationRecord
    enum currency: [ :BRL, :USD, :EUR ]
    has_many :products, dependent: :destroy


    validates :name, :cnpj, :country, :currency, presence: true
    validates :cnpj, uniqueness: true

end
