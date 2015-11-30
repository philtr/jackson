class DashboardController < ApplicationController
  before_action :require_authentication

  def index
    page_title "Your Events"

    @events = current_user.events
    @created_events = current_user.created_events
    @upcoming_events = @events.upcoming | @created_events.upcoming
    @past_events = @events.past | @created_events.past
  end

end
