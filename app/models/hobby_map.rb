class HobbyMap < ApplicationRecord
	belongs_to :hobby
	belongs_to :post
	belongs_to :user
end
