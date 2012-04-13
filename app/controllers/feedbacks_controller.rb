class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
    render :layout => 'other'
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    @feedback.user_id = current_user.id
    if @feedback.save
      redirect_to home_index_path
    else
      render :action => 'new'
    end
  end
end
