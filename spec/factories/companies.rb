FactoryBot.define do
  factory :company do
    name { FFaker::Lorem.phrase  }
    cnpj { Faker::Company.duns_number }
    user
    country { Faker::Address.country }
    currency {rand(0..2)}
    description { FFaker::Lorem.phrase }
    primary_color { "##{FFaker::Color.hex_code}" }
    enable { FFaker::Boolean.maybe }
  end
end