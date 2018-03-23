require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "works! (now write some real specs)" do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /users' do
    let(:valid_params) { { user: { name: 'foobar',
                                     email: 'foo@bar.com', 
                                     password: 'password', 
                                     password_confirmation: 'password' } } }
    context 'when the request is valid' do
      before { post '/users', params: valid_params }

      it 'should add a user to the database and render user view' do
        expect(User.first.name).to eq('foobar')
        expect(response).to redirect_to('/users/1')
        follow_redirect!
        expect(response).to render_template(:show)
      end
    end

    context 'when the request is invalid' do
      before { post '/users', params: { user: { name: 'foobar' } } }

      it 'should render new user view with errors' do
        expect(response).to render_template(:new)
        expect(response.body).to include('error')
      end
    end
  end
end
