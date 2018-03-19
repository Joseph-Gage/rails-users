require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before do
    @users = create_list(:user, 2)
    assign(:users, @users)
  end

  it "renders a list of users" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(@users.first.name)
    expect(rendered).to match(@users.first.email)
    expect(rendered).to match(@users.last.name)
    expect(rendered).to match(@users.last.email)
  end
end
