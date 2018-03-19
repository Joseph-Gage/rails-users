require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:my_user) { create(:user) }

  it 'should be valid' do
    expect(my_user).to be_valid
  end
end
