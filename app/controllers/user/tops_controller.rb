class User::TopsController < ApplicationController
	skip_before_action :authenticate_user!
	def top
		
	end
end
