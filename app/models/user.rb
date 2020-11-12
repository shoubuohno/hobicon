class User < ApplicationRecord

  attachment :image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         enum sex: {男性: 0, 女性: 1}

         enum area: {
            "---":0,
			北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
			茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
		    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
			岐阜県:21,静岡県:22,愛知県:23,三重県:24,
			滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
			鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
			徳島県:36,香川県:37,愛媛県:38,高知県:39,
			福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,
			沖縄県:47
			}

	has_many :posts, dependent: :destroy
	has_many :post_comments, dependent: :destroy
	has_many :post_goods, dependent: :destroy
	has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
	has_many :followings, through: :following_relationships
	has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
    has_many :followers, through: :follower_relationships
    has_many :entries
    has_many :chat_messages
    has_many :rooms, through: :entries
    has_many :user_hobby_maps, dependent: :destroy
    has_many :hobbies, through: :user_hobby_maps

	def following?(other_user)
		following_relationships.find_by(following_id: other_user.id)
	end

	def follow!(other_user)
		following_relationships.create!(following_id: other_user.id)
	end

	def unfollow!(other_user)
		following_relationships.find_by(following_id: other_user.id).destroy
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
