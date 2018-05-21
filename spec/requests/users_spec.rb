require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'POST /users' do
    let(:valid_params) { { user: { name: 'foobar',
                                     email: 'foo@bar.com', 
                                     password: 'password', 
                                     password_confirmation: 'password' } } }
    context 'when the request is valid' do
      before { post '/users', params: valid_params }

      it 'should add a user to the database, sign the user in and render user view' do
        created_user = User.first
        expect(created_user.name).to eq('foobar')
        expect(response).to redirect_to(created_user)
        expect(is_signed_in?).to be_truthy
        follow_redirect!
        expect(response).to render_template(:show)
        expect(response.body).to include('Welcome to Ideaz')
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

  describe 'PATCH /users/:id' do
    let!(:my_user) { create(:user) }

    context 'when the request is valid' do
      let(:valid_params) { { user: { name: 'newname',
        email: 'new@email', 
        password: '', 
        password_confirmation: '' } } }
      before { patch "/users/#{my_user.id}", params: valid_params }

      it 'should update the user and render user view' do
        edited_user = User.first
        expect(edited_user.name).to eq('newname')
        expect(edited_user.email).to eq('new@email')
        expect(response).to redirect_to(edited_user)
        follow_redirect!
        expect(response).to render_template(:show)
        expect(response.body).to include('User was successfully updated.')
      end
    end

    context 'when the request is invalid' do
      let(:invalid_params) { { user: { name: 'newname',
        email: 'new@email', 
        password: 'password1', 
        password_confirmation: 'password2' } } }
      before { patch "/users/#{my_user.id}", params: invalid_params }

      it 'should render new user view with errors' do
        expect(response).to render_template(:edit)
        expect(response.body).to include('error')
      end
    end
  end
end
