class Company < ApplicationRecord
    enum currency: [ :BRL, :USD, :EUR ]
    has_many :products
end
