require 'rails_helper'

RSpec.describe Company, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Product model
  it { should have_many(:products).dependent(:destroy) }
  # Validation tests
  # ensure columns name, cnpj, country and currency are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:cnpj) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:currency) }
  it { should validate_uniqueness_of(:cnpj) }

end
