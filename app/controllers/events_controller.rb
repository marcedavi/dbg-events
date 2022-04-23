class EventsController < ApplicationController
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

    def join
        @event = Event.find(params[:id])

        Participation.create(user: current_user, event: @event)
    
        redirect_to @event
    end

    def leave
        @event = Event.find(params[:id])

        Participation.where(user: current_user, event: @event).destroy_all
    
        redirect_to @event
    end

    private
        def event_params
            params.require(:event).permit(:name, :start_date, :end_date, :max_participants, :street, :city, :state, :country)
        end
end
