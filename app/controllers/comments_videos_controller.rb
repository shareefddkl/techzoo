class CommentsVideosController < ApplicationController
  def new
    @video = Video.find(params[:video_id])
    @comments_video = @video.comments.new
  end

  def create
    @course = Course.find(params[:course_id])
    @video = Video.find(params[:video_id])
    @comments_video = @video.comments.new(params[:comments_video])
    @comments_video.course_id = @course.id
    @comments_video.user_id = current_user.id
    if @comments_video.save
      render :update do |page|
        page.replace_html 'document_div', (render :partial => "videos/show", :layout => false)
      end
    end
  end
end
