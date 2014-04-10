class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :auth_path, :current_user, :current_user?
  helper_method :page_title

  protected

  def auth_path(provider = :github)
    "/auth/#{ provider }"
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    @current_user = nil
  end

  def current_user?
    current_user.present?
  end

  def page_title(title = nil)
    @page_title = title unless title.nil?
    @page_title
  end

  def require_authentication
    unless current_user?
      session[:return_path] = request.fullpath
      redirect_to root_path and return
    end
  end

  def sign_in_as(user)
    session[:user_id] = user.id
    @current_user = user
  end

end
