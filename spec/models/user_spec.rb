require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:my_user) { create(:user) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:name).is_at_most(50) }
  it { should validate_length_of(:email).is_at_most(255) }
  it { should validate_length_of(:password).is_at_most(50) }
  it { should validate_length_of(:password).is_at_least(8) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:email).case_insensitive }

  it 'should be valid' do
    expect(my_user).to be_valid
  end

  it 'should make email address lower case' do
    my_user.email = 'BIG@website.com'
    my_user.save
    expect(my_user.email).to eq('big@website.com')
  end

  describe 'authenticated?' do
    it 'should return false for a user with nil digest' do
      expect(my_user.authenticated?('')).to be_falsey
    end
  end
end
