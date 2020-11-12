class User::UsersController < ApplicationController
  before_action :user_check, only: [:matching, :following, :followers, :update, :edit]

  def index
  end

  def user_list
    @users = User.all
  end

  def following
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  def matching
    @users = current_user.followings & current_user.followers
  end

  def show
    @user = User.find(params[:id])
    @user_hobbies = @user.hobbies
    @user_posts = @user.posts
    #byebug
    #@is_match = current_user.following?(@user) && @user.following?(current_user)
    #チャット機能
    if user_signed_in?
      @current_user_entry = Entry.where(user_id: current_user.id)
      @user_entry = Entry.where(user_id: @user.id)
        unless @user.id == current_user.id
          @current_user_entry.each do |cu|
            @user_entry.each do |u|
              if cu.room_id == u.room_id then
                @is_room = true
                @room_id = cu.room_id
              end
            end
          end
          unless @is_room
            @room = Room.new
            @entry = Entry.new
          end
        end
    end
  end

  def edit
  	@user = User.find(params[:id])
    @hobby_list = @user.hobbies.pluck(:hobby_name).join(nil)
  end

  def update
  	@user = User.find(params[:id])
    hobby_list = params[:user][:hobby_name].split(nil)
    @user.update_attributes(user_params)
    @user.save_hobby(hobby_list)
    redirect_to user_path(@user.id)
  end


  private
  def user_params
    params.require(:user).permit(:user_name, :image, :sex, :area, :introduction)
  end

  def user_check
    @user = User.find(params[:id])

        if @user.id != current_user.id
          redirect_to users_path
        end
  end
end
