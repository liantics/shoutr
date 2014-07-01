class FollowingRelationship < ActiveRecord::Base

belongs_to :user
belongs_to :followed_users, class_name: "User" #for whatever id, load a user model
belongs_to :followers, class_name: "User" #for whatever id, load a user model

end
