class BackfillTextSubjectsAndShouts < ActiveRecord::Migration
#Any active record models that are used in a migration MUST include the class definition
#so that if the model is deleted in the future, the migration will still work, no matter what. 
#at this point in the migration, the TABLE will exist, because the migrations guarantee the 
#database will be in a certain state, but the MODEL may not still exist, if the way the app
# runs may have been changed.


	class TextSubject < ActiveRecord::Base
	end

	class Shout < ActiveRecord::Base
	end

  	def up
  		Shout.all.each do |shout|
	  		text_subject = TextSubject.create(body: shout.body)
	  		shout.subject_id = text_subject.id
	  		shout.subject_type = "TextSubject"
	  		shout.save
  		end

  		remove_column :shouts, :body

  		change_column_null :shouts, :subject_id, false
  		change_column_null :shouts, :subject_type, false
	end

	#adding a down, because it's not obvious to rails how to reverse what was done above
	#if we rollback
	#Do the activities in reverse order from the "up" - think of it as putting your socks on first
	#tnen putting on your shoes. WHen you're undoing that, you remove the shoes, then the socks. [h/t Chris]

	def down

		change_column_null :shouts, :subject_id, true
  		change_column_null :shouts, :subject_type, true

  		add_column :shouts, :body, :string, null: true

  		Shout.all.each do |shout|
  			text_subject = TextSubject.find(id: shout.subject_id)
	  		shout.update_attributes(body: text_subject.body)
	  	end

		#execute lets you run straight SQl commands in the migration
		#rails adds the ending semicolons for you, so you don't need them
		execute "UPDATE shouts SET subject_id = NULL, subject_type = NULL"

		#since there's no "where" clause, this deletes *everything* from the table
		execute "DELETE FROM text_subjects"
		
	end


end
