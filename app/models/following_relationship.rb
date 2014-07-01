class FollowingRelationship < ActiveRecord::Base

	#Will always need to define these self-referential joins via this style of belongs_to	

	belongs_to :followed_user, class_name: "User" #for whatever id, load a user model
	belongs_to :follower, class_name: "User" #for whatever id, load a user model

	#custom validation. 
	#In custom validation, the keyword validate is ALWAYS singular 
	validate :user_is_not_following_themselves

	private 
		def user_is_not_following_themselves
			#base is a catch-all for errors, it's used for validating things that span more than one column
			#if you're only validating a single column, use the specific item, for example: :follower
			if  follower.id == followed_user.id
				errors.add( :base, "error message here - for our app users cannot follow themselves" ) 
			end

		end
end
