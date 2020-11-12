class Hobby < ApplicationRecord
	has_many :hobby_maps, dependent: :destroy, foreign_key: 'hobby_id'
	has_many :posts, through: :hobby_maps
	has_many :user_hobby_maps, dependent: :destroy, foreign_key: 'hobby_id'
	has_many :users, through: :user_hobby_maps
end
