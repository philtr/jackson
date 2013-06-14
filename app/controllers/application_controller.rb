class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :auth_path, :current_user, :current_user?

  before_filter :external_css

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

  def external_css
    if params[:css]
      session[:css_url] = params[:css]
    end
  end

  def require_authentication
    unless current_user?
      session[:return_path] = request.fullpath
      redirect_to sign_in_path and return
    end
  end

  def login_as(user)
    session[:user_id] = user.id
    @current_user = user
  end
end
