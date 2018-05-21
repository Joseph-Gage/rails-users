require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let!(:my_user) { create(:user) }

  describe 'Sign in' do
    let(:valid_params) { { session: { email: my_user.email, password: my_user.password } } }

    context 'when user signs in with correct credentials' do
      it 'redirects to user page and renders Account dropdown in header' do
        get signin_path
        post signin_path, params: valid_params
        expect(is_signed_in?).to be_truthy
        expect(response).to redirect_to(my_user)
        follow_redirect!
        expect(response).to render_template(:show)
        expect(response.body).to include('Account')
      end
    end

    context 'when sign in fails' do
      it 'redirects to sign in page with notice' do
        post signin_path, params: { session: { email: 'fake@faker.com', password: 'fake' } }
        expect(is_signed_in?).to be_falsey
        expect(response).to redirect_to(signin_path)
        follow_redirect!
        expect(response).to render_template(:new)
        expect(response.body).to include('Invalid email/password combination')
      end
    end
  end

  describe 'Sign out' do
    let(:valid_params) { { session: { email: my_user.email, password: my_user.password } } }
    
    it 'clears the user from the session and redirects to the sign in page' do
      post signin_path, params: valid_params
      delete signout_path
      expect(is_signed_in?).to be_falsey
      expect(response).to redirect_to(signin_path)
      # simulate user clicking sign out in a second window
      delete signout_path
      follow_redirect!
      expect(response).to render_template(:new)
      expect(response.body).to include('Sign in')
    end
  end

  describe 'Sign in and Remember' do
    it 'adds correct remember token to cookies if remember me selected' do
      sign_in_post(my_user, remember_me: '1')
      expect(cookies['remember_token']).to eq(assigns(:user).remember_token)
    end

    it 'removes old remember token on new sign in' do
      sign_in_post(my_user, remember_me: '1')
      sign_in_post(my_user, remember_me: '0')
      expect(cookies['remember_token']).to be_empty
    end
  end
end
