class User::UsersController < ApplicationController
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
    @user_posts = @user.posts
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
  end

  def update
  	@user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end


  private
  def user_params
    params.require(:user).permit(:user_name, :image, :sex, :area, :introduction)
  end
end
