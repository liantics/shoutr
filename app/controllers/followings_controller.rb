class FollowingsController < ApplicationController
 
 def show
 	@users = current_user.followed_users.all
 end

	def create

		followee = User.find(params[:user_id])
		current_user.follow followee
		redirect_to 
	end

	def destroy
		followee = User.find(params[:user_id])
		current_user.unfollow(followee)

		redirect_to current_user
	end

end

