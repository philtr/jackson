class DashboardController < ApplicationController
  before_filter :require_authentication

  def index
    page_title "Your Events"

    @events = Event.user(current_user).upcoming
    @past_events = Event.user(current_user).past
  end

end
