class DiscussionsController < ApplicationController

  def new
    @document = Document.find(params[:document_id])
    @discussion = @document.discussions.new
  end

  def create
    @course = Course.find(params[:course_id])
    @document = Document.find(params[:document_id])
    @discussion = @document.discussions.new(params[:discussion])
    @discussion.course_id = @course.id
    @discussion.user_id = current_user.id
    if @discussion.save
      render :update do |page|
        page.replace_html 'document_div', (render :partial => "documents/show", :layout => false)
      end
    end
  end
end
