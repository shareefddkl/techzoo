class DocumentsController < ApplicationController
  
  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    render :update do |page|
      page <<  "$('document_#{params[:id]}').innerHTML = ''"
      page.alert("successfully deleted the Document.")
    end
  end

  def show
    @course = Course.find(params[:course_id])
    @document = @course.documents.find(params[:id])
    render :update do |page|
      page.replace_html 'document_div', (render :partial => "show", :layout => false)
    end
  end

end
