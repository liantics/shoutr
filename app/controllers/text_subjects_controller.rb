class TextSubjectsController < ApplicationController
	def create
		current_user.text_subjects.create(text_subject_params)
		redirect_to :dashboard

	end	

private
	def text_subject_params
		params.require(:text_subject).permit(
			:body,
			)
	end

end