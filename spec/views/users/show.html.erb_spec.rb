require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :name => "Name",
      :email => "Email",
      :password_digest => "Password Digest",
      :remember_digest => "Remember Digest",
      :admin => false,
      :activation_digest => "Activation Digest",
      :activated => false,
      :reset_digest => "Reset Digest"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Password Digest/)
    expect(rendered).to match(/Remember Digest/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Activation Digest/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Reset Digest/)
  end
end
