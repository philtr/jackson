class EventsController < ApplicationController
  before_filter :require_authentication, except: [ :show ]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.creator = current_user

    @event.save

    redirect_to root_path
  end

  def show
    @event = Event.where(id: params[:id]).includes(responses: [ :user ]).first
    @response = @event.response_for(current_user).presence || Response.new rescue nil
  end

  def responses
    redirect_to event_path(params[:id])
  end

  protected

  def event_params
    params.require(:event).permit(:name, :description, :starts_at, :ends_at, :location)
  end
end
