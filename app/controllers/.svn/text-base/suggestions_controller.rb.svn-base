class SuggestionsController < ApplicationController
skip_before_filter :is_loggedin?
layout :get_layout
  def new
    @suggestion = Suggestion.new
  end

  def create
    @suggestion = Suggestion.new(params[:suggestion])
    if @suggestion.save
      UserMailer.send_feedback(@suggestion).deliver
      flash[:notice] = "#{:suggestion_type} is successfully sent."
      redirect_to new_suggestion_path
    end
  end
end
