class Participation < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :user_id, uniqueness: { scope: :event_id }
  validate :validate_overlapping_event
  validate :validate_max_participants

  scope :of, -> (user) { where(user: user) }
  scope :by_organizer, -> (organizer) {
    joins(:event).where(events: { organizer: organizer })
  }
  scope :by_event, -> (event) { where(event: event) }

  def validate_overlapping_event
    if user.joined_events.where.not(id: event.id).overlapping(event.start_date, event.end_date).any?
      errors.add(:overlap_error, "Event overlaps with another event")
    end
  end

  def validate_max_participants
    if event.participants.count >= event.max_participants
      errors.add(:max_participants_error, "Event is full.")
    end
  end
end
