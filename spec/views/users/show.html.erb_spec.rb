require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before do
    @user = create(:user)
    assign(:user, @user)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(@user.name)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(@user.email)
  end
end
