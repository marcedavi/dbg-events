class ParticipationsController < ApplicationController

  def index
    @event = Event.find(params[:id])
  end

  def create
    @participation = Participation.new(user: current_user, event_id: params[:id])

    if @participation.save
      redirect_to @participation.event
    else
      @event = @participation.event
      render "events/show" , status: :unprocessable_entity
    end
  end

  def update
    @participation = Participation.find(params[:participation_id])

    if @participation.update(is_banned: !@participation.is_banned)
      redirect_to @participation.event
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @participation = Participation.find(params[:participation_id]).destroy
    redirect_to @participation.event
  end

  def remove
    @participation = Participation.find(params[:participation_id])
    @participation.is_banned = true
    @participation.save
    redirect_to participants_path(@participation.event)
  end
end
