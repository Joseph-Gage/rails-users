class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    respond_to do |format|
      if @user && @user.authenticate(params[:session][:password])
        sign_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to signin_path, notice: 'Invalid email/password combination' }
        format.json { render json: @user.errors, status: :unauthorized }
      end
    end
  end

  def destroy
    respond_to do |format|
      sign_out if signed_in?
      format.html { redirect_to signin_path }
      format.json { render json: 'signed out successfully', status: :no_content }
    end
  end
end
