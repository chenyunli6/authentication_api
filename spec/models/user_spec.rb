require 'rails_helper'

RSpec.describe User, type: :model do
  it 'ensure mobile and validate_code are present before save' do
    should validate_presence_of(:mobile)
    should validate_presence_of(:validate_code)
  end
end
