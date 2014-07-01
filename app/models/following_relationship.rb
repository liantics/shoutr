class FollowingRelationship < ActiveRecord::Base

	#Will always need to define these self-referential joins via this style of belongs_to

	belongs_to :followed_users, class_name: "User" #for whatever id, load a user model
	belongs_to :followers, class_name: "User" #for whatever id, load a user model

end
