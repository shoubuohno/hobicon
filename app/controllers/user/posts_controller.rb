class User::PostsController < ApplicationController
  def index
  	@posts = Post.all
    @hobby_list = Hobby.all
  end

  def new
  	@post = current_user.posts.new
  end

  def create
  	@post = current_user.posts.new(post_params)
    hobby_list = params[:post][:hobby_name].sqlit(nil)
    @post.save
    @post.save_hobby(hobby_list)
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
    @post_hobbies = @post.hobbies
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    @post.update(post_params)
    redirect_to posts_path
  end

  private
  def post_params
  	params.require(:post).permit(:image, :body)
  end
end
