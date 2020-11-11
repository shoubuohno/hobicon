class Hobby < ApplicationRecord
	has_many :hobby_maps, dependent: :destroy, foreign_key: 'tag_id'
	has_many :posts, through: :hobby_maps
end
