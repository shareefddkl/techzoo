class StatusesController < ApplicationController
   skip_before_filter :is_loggedin?
   layout 'admin'
  def index 
    
  end
  def mentor_info
     @mentor=Mentor.all
      @student=Student.all
      @course=Course.all
     puts ">>>>>>>>>>>>>>>>>>"
    puts params.inspect
    puts "<<<<<<<<<<<<<<"
    if params[:description] == 'mentor'
      @mentor_education_type = params[:mentor_education_type]
      unless params[:start_date].blank? && params[:end_date].blank?
        @mentor_status = Mentor.where("(mentors.education_type = '#{@mentor_education_type}') and (mentors.created_at BETWEEN '#{params[:start_date].to_date.strftime('%Y-%m-%d')}' AND '#{params[:end_date].to_date.strftime('%Y-%m-%d')}')").joins("LEFT JOIN users ON users.id = mentors.user_id" )
        @mentor_courses = Course.where("(mentors.education_type = '#{@mentor_education_type}') and (mentors.created_at BETWEEN '#{params[:start_date].to_date.strftime('%Y-%m-%d')}' AND '#{params[:end_date].to_date.strftime('%Y-%m-%d')}')").joins("LEFT JOIN users ON users.id = courses.user_id LEFT JOIN mentors ON mentors.user_id = users.id")
      end
      #      @mentor_status = Mentor.where("(mentors.education_type = '#{@mentor_education_type}') and (mentors.created_at BETWEEN '#{params[:start_date]}' AND '#{params[:end_date]}')").joins("LEFT JOIN users ON users.id = mentors.user_id" )
      #      @mentor_courses = Course.where("(mentors.education_type = '#{@mentor_education_type}') and (mentors.created_at BETWEEN '#{params[:start_date]}' AND '#{params[:end_date]}')").joins("LEFT JOIN users ON users.id = courses.user_id LEFT JOIN mentors ON mentors.user_id = users.id")
    else
      @student_education_type = params[:student_education_type]
      unless params[:start_date].blank? && params[:end_date].blank?
        @student_status = Student.where("(students.education_type = '#{@student_education_type}') and (students.created_at BETWEEN '#{params[:start_date].to_date.strftime('%Y-%m-%d')}' AND '#{params[:end_date].to_date.strftime('%Y-%m-%d')}')").joins("LEFT JOIN users ON users.id = students.user_id" )
        @student_courses = CoursesStudent.where("(students.education_type = '#{@student_education_type}' and courses_students.status != 'rejected') and (students.created_at BETWEEN '#{params[:start_date].to_date.strftime('%Y-%m-%d')}' AND '#{params[:end_date].to_date.strftime('%Y-%m-%d')}')").joins("LEFT JOIN courses ON courses.id = courses_students.course_id LEFT JOIN students ON students.id = courses_students.student_id LEFT JOIN users ON users.id = students.user_id")
         end
    end
    #@student_courses = CoursesStudent.where("students.id = '#{@student.id}'").joins("LEFT JOIN courses ON courses.id = courses_students.course_id LEFT JOIN students ON students.id = courses_students.student_id LEFT JOIN users ON users.id = students.user_id")
  end
   def get_course_graph_form
     @course_type=params[:course_type]
    # @course_fee=params[:course_fee]
    #@course_graph = Course.new(:course_type => params[:id])
    #1.times { @course.documents.build }
    #1.times { @course.videos.build }
    render :partial => 'course_graph_form', :layout => false
  end
  def student_info
    @student=Student.all
  end
  def get_mentor
    #@getinfo = Mentor.find(params[:education_type])
    #@getcourses = @getinfo.courses

  end
end
