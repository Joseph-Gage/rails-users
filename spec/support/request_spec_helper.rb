module RequestSpecHelper
  def is_signed_in?
    !session[:user_id].nil?
  end

  def sign_in_session(user)
    session[:user_id] = user.id
  end

  def sign_in_post(user, remember_me: '1')
    post signin_path, params: { session: { email: user.email,
                                           password: user.password,
                                           remember_me: remember_me } }
  end
end
