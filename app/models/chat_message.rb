class ChatMessage < ApplicationRecord
	belongs_to :user
	belongs_to :room
	after_create_commit { ChatMessageBroadcastJob.perform_later self }
end
