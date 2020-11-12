class User::RoomsController < ApplicationController


	def index
		@user = current_user
		@current_entries = current_user.entries
		my_room_ids = []
		@current_entries.each do |entry|
			my_room_ids << entry.room.id
		end
		@another_entries = Entry.where(room_id: my_room_ids).where.not(user_id: @user.id).order(created_at: :desc)
	end

	def show
		@room = Room.find(params[:id])
		if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
			@chat_messages = @room.chat_messages
			@entries = @room.entries
		else
		    redirect_back(fallback_location: users_path)
		end
	end

	def create
		@room = Room.create(:name => "chat")
		@entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
		@entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
		redirect_to room_path(@room.id)
	end

	def destroy
		room = Room.find(params[:id])
		room.destroy
		redirect_to rooms_path
	end

end
