class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, only: [:created_events]
  def created_events
    @title = "Created Events"
    @events = current_user.created_events

    authorize current_user
  end

  def joined_events
    @title = "Joined Events"
    @events = current_user.joined_events
  end

end
