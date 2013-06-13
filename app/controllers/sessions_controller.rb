class SessionsController < ApplicationController
  # GET /sign-in
  def new
  end

  # GET /sign-out
  def destroy
    session[:user_id] = nil
    @current_user = nil

    redirect_to params[:return_path].presence || root_path
  end

  # GET /auth/:provider/callback?param=a98xh0xeui2sc
  def create
    @user = User.find_or_create_from_auth(auth)
    login_as(@user)

    redirect_to params[:return_path].presence || root_path
  end


  protected

  def auth
    Auth.new(request.env['omniauth.auth'])
  end
end
