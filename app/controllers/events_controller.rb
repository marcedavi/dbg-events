class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  after_action :verify_authorized, except: [:index, :show]

  def index
    @title = "Events"
    if params[:query].present?
      @events = Event.with_name_like(params[:query])
    else
      @events = Event.all
    end
  end

  def show
    @event = Event.find(params[:id])
    @participation = @event.participations.find_by(user_id: current_user.id)
    @title = @event.name
  end

  def new
    @event = Event.new

    authorize @event
  end
  
  def create
    @event = current_user.created_events.new(event_params)

    authorize @event

    if @event.save
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def event_params
      params.require(:event).permit(:name, :start_date, :end_date, :max_participants, :street, :city, :state, :country)
    end
end
