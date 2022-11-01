class ParticipationPolicy < ApplicationPolicy
  def index?
    record.organizer == user
  end

  def update?
    true
  end

  def destroy?
    record.user == user
  end

end