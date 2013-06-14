class ResponsesController < ApplicationController
  before_filter :require_authentication

  def index
  end

  def new
    render text: "Must provide event identifier." and return unless rsvp_params[:event]

    @response = Response.new do |r|
      r.event_id      = rsvp_params[:event]
      r.organization  = rsvp_params[:org]
    end
  end

  def create
    @response = Response.new(response_params)
    @response.user_id = current_user.id

    if @response.save
      redirect_to responses_path
    end
  end

  protected

  def response_params
    params.require(:response).permit(:event_id, :organization, :additional_guests, :comments)
  end

  def rsvp_params
    params.permit(:event, :org, :css, :additional_guests, :comments)
  end
end
