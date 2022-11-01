class EventPolicy < ApplicationPolicy
  def create?
    user.is_organizer?
  end

  def notify?
    record.organizer == user
  end
end