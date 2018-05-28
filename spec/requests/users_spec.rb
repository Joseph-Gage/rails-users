require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET /users' do
    context 'when user not signed in' do
      it 'should redirect to sign in page' do
        get users_path
        expect(response).to redirect_to(signin_url)
      end
    end
  end

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

  describe 'GET /users/:id/edit' do
    let!(:my_user) { create(:user) }

    it 'should do friendly forwarding on first attempt' do
      get edit_user_path(my_user)
      sign_in_post(my_user)
      expect(response).to redirect_to(edit_user_path(my_user))
      sign_in_post(my_user)
      expect(response).to redirect_to(my_user)
    end
  end

  describe 'PATCH /users/:id' do
    let!(:users) { create_list(:user, 2) }
    let!(:my_user) { users[0] }
    let(:valid_params) { { user: { name: 'newname',
      email: 'new@email', 
      password: '', 
      password_confirmation: '' } } }

    context 'when the request is valid' do
      it 'should update the user and render user view' do
        sign_in_post(my_user)
        patch "/users/#{my_user.id}", params: valid_params
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
      before { sign_in_post(my_user) }
      before { patch "/users/#{my_user.id}", params: invalid_params }

      it 'should render new user view with errors' do
        expect(response).to render_template(:edit)
        expect(response.body).to include('error')
      end
    end

    context 'when not signed in' do
      it 'should redirect from edit to sign in page with notice' do
        get edit_user_path(my_user)
        expect(response).to redirect_to(signin_path)
        follow_redirect!
        expect(response).to render_template(:new)
        expect(response.body).to include('Please sign in.')
      end

      it 'should redirect from update to sign in page with notice' do
        patch "/users/#{my_user.id}", params: valid_params
        expect(response).to redirect_to(signin_path)
        follow_redirect!
        expect(response).to render_template(:new)
        expect(response.body).to include('Please sign in.')
      end
    end

    context 'when signed in as wrong user' do
      before { sign_in_post(users[1]) }

      it 'should redirect from edit to homepage with notice' do
        get edit_user_path(my_user)
        expect(response).to redirect_to(root_url)
        follow_redirect!
        expect(response).to render_template(:new)
        expect(response.body).to include('Unauthorized.')
      end

      it 'should redirect from update to homepage with notice' do
        patch "/users/#{my_user.id}", params: valid_params
        expect(response).to redirect_to(root_url)
        follow_redirect!
        expect(response).to render_template(:new)
        expect(response.body).to include('Unauthorized.')
      end
    end
  end
end
