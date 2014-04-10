class BaseController < ApplicationController
  before_filter :require_signed_out

  def home
    page_title "Home"
  end

  private

  def require_signed_out
    redirect_to dashboard_path if current_user?
  end
end
