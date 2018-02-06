FactoryBot.define do
  factory :product do
    name { FFaker::Lorem.word }
    price { Faker::Number.decimal(2, 3) }
    company
  end
end