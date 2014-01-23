class DashboardController < ApplicationController
  before_filter :require_authentication

  def index
    @events = my_upcoming_events
  end

  protected

  def my_upcoming_events
    events = current_user.events.upcoming.limit(10)
    events += current_user.created_events.upcoming.limit(10)
    events.uniq.slice(0,9)
  end
end
