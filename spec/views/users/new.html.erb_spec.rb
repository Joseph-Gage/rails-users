require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      :name => "MyString",
      :email => "MyString",
      :password_digest => "MyString",
      :remember_digest => "MyString",
      :admin => false,
      :activation_digest => "MyString",
      :activated => false,
      :reset_digest => "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[name]"

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[password_digest]"

      assert_select "input[name=?]", "user[remember_digest]"

      assert_select "input[name=?]", "user[admin]"

      assert_select "input[name=?]", "user[activation_digest]"

      assert_select "input[name=?]", "user[activated]"

      assert_select "input[name=?]", "user[reset_digest]"
    end
  end
end
