require 'rails_helper'

describe SessionsHelper do
  describe 'current_user' do
    let!(:my_user) { create(:user) }
    before(:each) do
      remember(my_user)
    end

    it 'returns correct user when session is nil' do
      expect(my_user).to eq(current_user)
      expect(signed_in?).to be_truthy
    end

    it 'returns nil when remember digest is wrong' do
      my_user.update_attribute(:remember_digest, User.digest(User.new_token))
      expect(current_user).to be_nil
    end
  end
end