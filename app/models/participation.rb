class Participation < ApplicationRecord
    belongs_to :event
    belongs_to :user

    validates :user_id, uniqueness: { scope: :event_id }
    validate :validate_overlapping_event

    def validate_overlapping_event
        if user.joined_events.where.not(id: event.id).overlapping(event.start_date, event.end_date).any?
            errors.add(:overlap_error, "Event overlaps with another event")
        end
    end
end
