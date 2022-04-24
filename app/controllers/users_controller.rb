class UsersController < ApplicationController

  def created_events
    @title = "Created Events"
    @events = current_user.created_events
  end

  def joined_events
    @title = "Joined Events"
    @events = current_user.joined_events
  end

end
