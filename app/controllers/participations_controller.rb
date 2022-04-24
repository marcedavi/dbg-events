class ParticipationsController < ApplicationController

    def create
        @event = Event.find(params[:event_id])
        
        @participation = Participation.create(user: current_user, event: @event)
        flash[:notice] = @participation.errors.full_messages.join(", ") unless @participation.valid?

        redirect_to @event
    end

    def destroy
        @event = Event.find(params[:event_id])
        Participation.where(user: current_user, event: @event).destroy_all
        redirect_to @event
    end
end
