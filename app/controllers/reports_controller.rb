class ReportsController < ApplicationController
  skip_before_filter :is_loggedin?
   layout 'admin'
  def index

  end
  def overview
    @menter_count=Mentor.all.count
    @proffesors=Mentor.where("education_type = 'professor'").count
    @school=Mentor.where("education_type = 'school'").count
    @corporate=Mentor.where("education_type = 'corporate'").count
    @research=Mentor.where("education_type = 'research'").count
    @professoinal=Mentor.where("education_type = 'professional'").count
    @good=Mentor.where("education_type = 'good'").count
    @student_count=Student.all.count
    @in_school=Student.where("education_type = 'in_school'").count
    @college=Student.where("education_type = 'college'").count
    @pg=Student.where("education_type = 'pg'").count
    @phd=Student.where("education_type = 'phd'").count
    @professional_student=Student.where("education_type = 'professional'").count
    @others=Student.where("education_type = 'other'").count
  end
  def traffic_source
    
  end
  def member_report
  @user_report=User.all
  end
  def member_search
     @name = params[:name]
     @id= params[:id]
    @users = User.search(@name)
    @users1 = User.search(@id)
      end
end
