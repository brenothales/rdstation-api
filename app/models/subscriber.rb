class Subscriber < ApplicationRecord
    belongs_to :manager, class_name: 'Company'
    belongs_to :payer, class_name: 'Company'
    belongs_to :product
end
