class User < ActiveRecord::Base
	has_many :shouts

	has_many :followed_user_relationships, 
		class_name: "FollowingRelationship", #this MUST be a string, cannot be a symbol
		foreign_key: :follower_id #we're telling the user model (the file we're in right now), what foreign key to look up

	has_many :followed_users, 
		through: :followed_user_relationships


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

  