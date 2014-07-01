class FollowingRelationshipsController < ApplicationController

	def create
		#find the person we want to follow
		followed_user = User.find(params[:user_id])

		#call a method (in users controller) to actually follow that user
		#we're following the user *through* current_user
		current_user.follow(followed_user)

		#when the "follow " has been created, return the user to where they started
		#which is the page on which they clicked the follow button. 
		#we can use back here because the user isn't clicking it, so it won't
		#bounce them back to whatever random prior page they were on before accessing the
		#page with the button (which could be another site)
		redirect_to :back
	end

	def destroy
		followed_user = User.find(params[:user_id])
		current_user.unfollow(followed_user)
		redirect_to :back
	end

end
