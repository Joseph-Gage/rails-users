require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:my_user) { create(:user) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_length_of(:name).is_at_most(50) }
  it { should validate_length_of(:email).is_at_most(255) }

  it 'should be valid' do
    expect(my_user).to be_valid
  end
end
