class User::PostGoodsController < ApplicationController
	def create
		post = Post.find(params[:post_id])
		post_good = current_user.post_goods.new(post_id: post.id)
		post_good.save
		redirect_to post_path(post)
	end

	def destroy
		post = Post.find(params[:post_id])
		post_good = current_user.post_goods.find_by(post_id: post.id)
		post_good.destroy
		redirect_to post_path(post)
	end
end
