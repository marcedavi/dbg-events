class Event < ApplicationRecord
    belongs_to :organizer, foreign_key: :organizer_id, class_name: "User"
    has_many :participations
    has_many :participants, through: :participations, class_name: "User"

    validates :name, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :max_participants, presence: true
    validates :street, presence: true
    validates :city, presence: true
    validates :state, presence: true
    validates :country, presence: true

    geocoded_by :address
    after_validation :geocode

    def address
        [street, city, state, country].compact.join(', ')
    end

    scope :with_name_like, ->(query) { where("name LIKE ?","%#{query}%") }

end
