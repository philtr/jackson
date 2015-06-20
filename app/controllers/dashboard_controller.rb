class DashboardController < ApplicationController
  before_filter :require_authentication

  def index
    page_title "Your Events"

    @events = current_user.events.upcoming
    @past_events = current_user.events.past
  end

end
