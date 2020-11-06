class Hobby < ApplicationRecord
	has_many :hobby_maps, dependent: :destroy
end
