class Post < ApplicationRecord

	default_scope -> { order(created_at: :desc) }
	attachment :image

    belongs_to :user
	has_many :post_comments, dependent: :destroy
	has_many :post_goods, dependent: :destroy
	has_many :hobby_maps, dependent: :destroy
	has_many :hobbies, through: :hobby_maps

   def post_gooded_by?(user)
    post_goods.where(user_id: user.id).exists?
   end

   def save_hobby(sent_hobbies)
    current_hobbies = self.hobbies.pluck(:hobby_name) unless self.hobbies.nil?
    old_hobbies = current_hobbies - sent_hobbies
    new_hobbies = sent_hobbies - current_hobbies

    old_hobbies.each do |old|
      self.hobbies.delete Hobby.find_by(hobby_name: old)
    end

    new_hobbies.each do |new|
      new_hobby = Hobby.find_or_create_by(hobby_name: new)
      self.hobbies << new_hobby
    end
   end


end
