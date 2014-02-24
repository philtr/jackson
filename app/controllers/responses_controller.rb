class ResponsesController < ApplicationController
  before_filter :require_authentication

  def index
    @event = Event.find(params[:event_id])
    redirect_to @event
  end

  def create
    @event = Event.find(params[:event_id])

    unless Response.where(event_id: @event.id, user_id: current_user.id).any?
      @response = Response.new(event: @event)
      @response.user = current_user
      @response.save
    end

    redirect_to event_path(@event)
  end

  def update
    @response = Response.find(params[:id])

    if @response.user == current_user
      @response.update_attributes(response_params)
    end

    redirect_to event_path(@response.event)
  end

  def destroy
    @response = Response.find(params[:id])

    if @response.user == current_user
      @response.destroy
    end

    redirect_to event_path(@response.event)
  end

  protected

  def response_params
    params.require(:response).permit(:event_id, :additional_guests, :comments)
  end

end
