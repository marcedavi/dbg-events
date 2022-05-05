class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :created_events, inverse_of: :organizer, foreign_key: :organizer_id, class_name: "Event"

  has_many :participations
  has_many :joined_events, through: :participations, :source => :event

  has_many :chat_participations, :class_name => "Chat::Participation"
  has_many :chat_rooms, through: :chat_participations, :source => :chat_room
  
  has_many :notifications, as: :recipient
end
