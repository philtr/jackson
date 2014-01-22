class DashboardController < ApplicationController
  before_filter :require_authentication

  def index
    @events = current_user.events.upcoming.limit(5)
  end
end
