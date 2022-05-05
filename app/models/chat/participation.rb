class Chat::Participation < ApplicationRecord
  belongs_to :chat_room, class_name: "Chat::Room"
  belongs_to :user
end
