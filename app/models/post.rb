class Post < ApplicationRecord

	attachment :image

    belongs_to :user
	has_many :post_comments, dependent: :destroy
	has_many :post_goods, dependent: :destroy
	has_many :hobby_msps, dependent: :destroy

    


	def post_gooded_by?(user)
		post_goods.where(user_id: user.id).exists?
	end
end
