class OthersController < ApplicationController

  def user_info
    @users = User.all
    @mentors = Mentor.all
    @students = Student.all
    render :layout => 'other'
  end

  def current_course
    @current_courses = Course.all
    render :layout => 'other'
  end

  def history
    render :layout => 'other'
  end

  def feedback
    render :layout => 'other'
  end

  def blog
    render :layout => 'other'
  end
end
