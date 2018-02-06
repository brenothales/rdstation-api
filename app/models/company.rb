class Company < ApplicationRecord

    belongs_to :user
    has_many :products, dependent: :destroy

    extend FriendlyId
    friendly_id :name, use: :slugged

    validates :name, :cnpj, :country, :currency, :user, presence: true
    validates :cnpj, uniqueness: true

    enum currency: [ :usd, :brl, :eur ]

end
