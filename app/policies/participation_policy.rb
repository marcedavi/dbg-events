class ParticipationPolicy < ApplicationPolicy
  def index?
    record.organizer == user
  end

  def destroy?
    record.user == user
end