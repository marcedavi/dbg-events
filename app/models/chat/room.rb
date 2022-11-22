class Chat::Room < ApplicationRecord
  has_many :messages, :class_name => "Chat::Message", :foreign_key => "chat_room_id"
  has_many :chat_participations, :class_name => "Chat::Participation", :foreign_key => "chat_room_id"
  has_many :participants, through: :chat_participations, :source => :user

  scope :by_participant, -> user1 {
    joins(:chat_participations).where(chat_participations: {user: user1})
  }

  scope :by_participants, -> user1, user2 {
    joins(:chat_participations).where('chat_participations.user_id IN (' + user1.id.to_s + ', ' + user2.id.to_s + ')').group('id').having('count(1) = 2')
  }
end
