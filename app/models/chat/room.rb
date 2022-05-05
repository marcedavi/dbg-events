class Chat::Room < ApplicationRecord
  has_many :messages, :class_name => "Chat::Message", :foreign_key => "chat_room_id"
  has_many :chat_participations, :class_name => "Chat::Participation", :foreign_key => "chat_room_id"
  has_many :participants, through: :chat_participations, :source => :user

  scope :by_participants, -> users {
    joins(:chat_participations).where(chat_participations: {user: users})
  }
end
