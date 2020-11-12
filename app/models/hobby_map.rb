class HobbyMap < ApplicationRecord
	belongs_to :post
	belongs_to :hobby
	validates :post_id, presence: true
    validates :hobby_id, presence: true
end
