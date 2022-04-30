class EventPolicy < ApplicationPolicy
  def create?
    user.is_organizer?
  end
end