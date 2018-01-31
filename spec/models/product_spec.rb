require 'rails_helper'

RSpec.describe Product, type: :model do
  # Association test
  # ensure an product record belongs to a single company record
  it { should belong_to(:company) }
  # Validation test
  # ensure column name, and price is present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }

end



