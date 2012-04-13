class VideosController < ApplicationController
  
  
  #method to delete video
  #url: /videos/:id
  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    render :update do |page|
      page <<  "$('video_#{params[:id]}').innerHTML = ''"
      page.alert("successfully deleted the Video.")
    end
  end

  def show
    @course = Course.find(params[:course_id])
    @video = @course.videos.find(params[:id])
    render :update do |page|
      page.replace_html 'document_div', (render :partial => "show", :layout => false)
    end
  end
end