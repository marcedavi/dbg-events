class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  after_action :verify_authorized, except: [:index, :show]

  def index
    @title = "Events"

    @events = Event.all

    if params[:query].present?
      @events = @events.with_name_like(params[:query])
    end

    if params[:query_city].present?
      @events = @events.near_city(params[:query_city])
    end
  end

  def show
    @event = Event.find(params[:id])
    @participation = @event.participations.find_by(user_id: current_user.id)
    
    room = Chat::Room.by_participants(current_user, @event.organizer).first
    if room.nil?
      @room_id = -1
    else
      @room_id = room.id
    end

    @title = @event.name
  end

  def new
    @event = Event.new

    authorize @event
  end
  
  def create
    @event = current_user.created_events.new(event_params)
    @event.image.attach(params[:image])

    authorize @event

    if @event.save
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id]).destroy
    
    authorize @event

    redirect_to created_events_url
  end

  private
    def event_params
      params.require(:event).permit(:image, :name, :start_date, :end_date, :max_participants, :street, :city, :state, :country)
    end
end
