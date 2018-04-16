module RequestSpecHelper
  def is_signed_in?
    !session[:user_id].nil?
  end
end
