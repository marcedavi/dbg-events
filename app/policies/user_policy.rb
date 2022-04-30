class UserPolicy < ApplicationPolicy
  def created_events?
    record.is_organizer?
  end
end