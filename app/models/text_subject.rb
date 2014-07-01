class TextSubject < ActiveRecord::Base

	belongs_to :user

	def text_subject=(new_body)
  	self[:body] = new_body.upcase #accesses the :body column in the database. Overrides the default :body= method created by ActiveRecord. Uppercases the text.
  end

end
