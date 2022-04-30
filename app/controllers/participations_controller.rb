class ParticipationsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: [:create]

  def index
    @event = Event.find(params[:event_id])

    authorize @event, policy_class: ParticipationPolicy
  end

  def create
    @participation = Participation.new(user: current_user, event_id: params[:event_id])

    if @participation.save
      redirect_to @participation.event
    else
      @event = @participation.event
      render "events/show" , status: :unprocessable_entity
    end
  end

  def update
    @participation = Participation.find(params[:id])

    authorize @participation

    if @participation.update(is_banned: !@participation.is_banned)
      redirect_to @participation.event
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @participation = Participation.find(params[:id]).destroy
    
    authorize @participation

    redirect_to @participation.event
  end

end
