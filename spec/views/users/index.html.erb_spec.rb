require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :name => "Name",
        :email => "Email",
        :password_digest => "Password Digest",
        :remember_digest => "Remember Digest",
        :admin => false,
        :activation_digest => "Activation Digest",
        :activated => false,
        :reset_digest => "Reset Digest"
      ),
      User.create!(
        :name => "Name",
        :email => "Email",
        :password_digest => "Password Digest",
        :remember_digest => "Remember Digest",
        :admin => false,
        :activation_digest => "Activation Digest",
        :activated => false,
        :reset_digest => "Reset Digest"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Password Digest".to_s, :count => 2
    assert_select "tr>td", :text => "Remember Digest".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Activation Digest".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Reset Digest".to_s, :count => 2
  end
end
