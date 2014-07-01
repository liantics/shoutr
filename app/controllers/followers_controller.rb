class FollowersController < ApplicationController
 
 def show
 	@followers = current_user.followers.all #need to define the has_many relationships in the user.rb for the followers to make sense tot the server
 end

end