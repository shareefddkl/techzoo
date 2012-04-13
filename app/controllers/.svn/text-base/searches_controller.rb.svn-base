class SearchesController < ApplicationController
  def index
    
  end
  def accountid_search
    @users = User.search(params[:query])
  end
  
  def name_search
    @users = User.search(params[:query])
  end

  def course_search
    @courses = Course.search(params[:query])
  end


  def advance_search
    query = []
    @users = params[:all] == 'Mentor' ? Mentor : Student
    query <<  "#{params[:first_name]}" if params[:first_name].present?
    query <<  "#{params[:last_name]}" if params[:last_name].present?
    query <<  "#{params[:city]}" if params[:city].present?
    query <<  "#{params[:state]}" if params[:state].present?
    unless params[:all] == 'Student'
      query <<  "#{params[:mentor_education_type]}" if params[:mentor_education_type].present?
      query <<  "#{params[:status]}" if params[:status].present?
      query << "#{params[:course]}" if params[:course].present?
    else
      query <<  "#{params[:student_education_type]}" if params[:student_education_type].present?
    end
    @search_users = @users.search(query)
  end
end
