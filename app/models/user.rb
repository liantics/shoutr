class User < ActiveRecord::Base
	has_many :shouts

	#Set up to enable the current user to follow other users, via the follower_id key in the following_relationships table
	# in this case, when a user clicks the follow button, their ID will be set to the follower_id in the table, and the other user's 
	#id will be set to the followed_user_id.

	has_many :followed_user_relationships, 
		class_name: "FollowingRelationship", #this MUST be a string, cannot be a symbol
		foreign_key: :follower_id #we're telling the user model (the file we're in right now), what foreign key to look up

	has_many :followed_users, 
		through: :followed_user_relationships


	#Set up to enable users to see their followers, via the current user's followed_user_id key in the following_relationships table
	# in this case, when a user clicks the show followers button, the system will look for the current_user's ID in the 
	#followed_user_id column and find all the users whose id is in the follower_id column

	has_many :follower_relationships, 
		class_name: "FollowingRelationship",
		foreign_key: :followed_user_id

	has_many :followers,
		through: :follower_relationships

	has_many :text_subjects,
		through: :shouts, source_type: "TextSubject", source: :subject
	


	def follow(followee)
		followed_users << followee
	end

	def following?(other_user)
		followed_user_ids.include?(other_user.id) #has many defines the followed_user_ids for us
	end

	def unfollow(other_user)
		followed_users.destroy(other_user)
	end

end

  