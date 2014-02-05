class DashboardController < ApplicationController
  before_filter :require_authentication

  def index
    @events = Event.user(current_user).upcoming
    @past_events = Event.user(current_user).past
  end

end
