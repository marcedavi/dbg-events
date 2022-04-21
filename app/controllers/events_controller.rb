class EventsController < ApplicationController
    def index
        @title = "Events"
        @events = Event.all
    end

    def show
        @event = Event.find(params[:id])
        @title = @event.name
    end

    def new
        @event = Event.new
    end
    
    def create
        @event = current_user.created_events.new(event_params)
    
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
