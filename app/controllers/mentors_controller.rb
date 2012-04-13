class MentorsController < ApplicationController
  before_filter :get_mentor_object, :only => [:new, :education, :update_education, :others, :update_others, :edit,:profile, :update, :destroy, :get_education_form, :education_profile, :update_education_profile,:interest,:update_interest,:work,:update_work,:basic_info,:update_basic_info, :get_education_profile_form]
  before_filter :is_mentor_exists?, :only => [:edit, :update, :destroy, :education, :update_education, :others, :update_others]
  layout :get_layout, :except => [:new, :create, :education, :get_education_form, :update_education, :others, :update_others, :edit, :update ]
  skip_before_filter :is_loggedin?, :only => [:mentor_view, :show]

  def index
  end
  #GET mentors/new

  def new
    unless @mentor
      @mentor = Mentor.new
      render :layout => "application"
    else
      redirect_to edit_mentor_path(@mentor)
    end
  end

  #POST mentors/
  def create
    @mentor = Mentor.new(params[:mentor])
    @mentor.user_id = current_user.id
    if @mentor.save
      flash[:notice]="Mentor personal details created succefully"
      redirect_to education_mentor_path(@mentor)
    else
      flash[:error]="Mentor personal details creation failed"
      render :action => :new
    end
  end

  #GET /mentors/:id/education
  def education
    render :layout => "application"
  end

  def get_education_form
    render :partial => "education_form", :locals => {:education_type => params[:education_type]}
  end

  #PUT /mentors/:id/update_education
  def update_education
    if @mentor.update_attributes(params[:mentor])
      flash[:notice]="Mentor education form updated succefully"
      render :update do |page|
        page.redirect_to others_mentor_path
      end
    else
      flash[:error]="Mentor education form updation failed"
      render :update do |page|
        page.replace_html "education_form", (render :partial => "education_form", :locals => {:education_type => params[:mentor][:education_type]})
      end
    end
  end

  def show
    @mentor = Mentor.find(params[:id])
    render :layout => 'other'
  end

  #GET /mentors/:id/others
  def others
    @user = current_user.id
    @invite = Invite.new
    render :layout => "application"
  end

   #POST
  #Send invitation users.
  def invite
    @invite = Invite.new(params[:invite])
    @invite.user_id = current_user.id
     render :update do |page|
      if @invite.save
        #UserMailer.send_invitation(@invite).deliver
        if params[:action] == "invite_friends"
          page.alert('Invitation sent successfully')
        else
          page.alert('Invitation sent successfully')
          page.redirect_to home_index_path
        end
      else
        params[:emails].present? ? page.alert('Please Enter Correct Email') : page.alert('Please Enter Atleast One Email')
      end
    end
  end

  def invite_friends
     @invite = Invite.new
  end

  #PUT /mentors/:id/update_others
  def update_others
  end

  #GET /mentors/:id/edit
  def edit
    render :layout => "application"
  end
  
  #PUT /mentors/1
  def update
    if @mentor.update_attributes(params[:mentor])
      flash[:notice]="Mentor personal details updated succefully"
      redirect_to education_mentor_path(@mentor)
    else
      flash[:error]="Mentor personal details updation failed"
      render :action => :edit
    end
  end

  def basic_info
  end

  def update_basic_info
    if@mentor.update_attributes(params[:mentor])
      flash[:notice]="Mentor personal details updated succefully"
    else
      flash[:error] = "Mentor personal details updated failed"
    end
    redirect_to basic_info_mentors_path(@mentor)
  end

  def picture
  end

  def get_education_profile_form
    render :partial => "education_profile_form", :locals => {:education_type => params[:education_type]}
  end

  def education_profile
  end

  def update_education_profile
    if @mentor.update_attributes(params[:mentor])
      flash[:notice]="mentor education form updated succefully"
      render :update do |page|
        page.redirect_to education_profile_mentor_path(@mentor)
      end
    else
      flash[:error]="mentor education form updation failed"
      render :update do |page|
        page.replace_html "education_profile_form", (render :partial => "education_profile_form", :locals => {:education_type => params[:mentor][:education_type]})
      end
    end
  end

  def work
  end

  def update_work
    if @mentor.update_attributes(params[:mentor])
      flash[:notice] = "Mentor Work details updated succefully"
    else
      flash[:error] = "Mentor Work details updation failed"
    end
    redirect_to work_mentors_path
  end

  def interest
  end

  def other_message
    @mentor = Mentor.find(params[:id])
    render :partial => 'mentor_message', :layout => false
  end

  def mentor_message
    @mentor = Mentor.find(params[:id])
    @mentor_message = Message.new(params[:mentor_message].merge({:user_id => current_user.id, :receiver_id => @mentor.user.id})).save
    render :update do |page|
      page.replace_html "message_notice", "Your's message sucessfully sent."
    end
  end

  def update_interest
    if @mentor.update_attributes(params[:mentor])
      flash[:notice] = "Mentor interest details updated succefully"
    else
      flash[:error] = "Mentor interest details updation failed"
    end
    redirect_to interest_mentors_path
  end

  def get_mentor_object
    @mentor = current_user.mentor
  end
  
  def is_mentor_exists?
    unless @mentor
      redirect_to new_mentor_path
    end
  end

  def mentor_current_course
    @mentor = Mentor.find(params[:id])
    @mentor_courses = @mentor.user.courses
    render :partial => "mentor_current_course", :layout => false
    #render :update do |page|
      #page.replace_html 'current_course', (render :partial => "mentor_current_course", :layout => false)
    #end
  end

  def feedback
    @mentor = params[:id] ? Mentor.find(params[:id]) : User.courses.first
    #@course = params[:id] ? Course.find(params[:id]) : current_user.courses.first
    #if @course
    # @course_feedbacks = @course.feedbacks
    #else
    #end
  end

  def mentor_view
    @mentor = Mentor.find(params[:id])
    render :update do |page|
      page.replace_html 'show_div', (render :partial => 'mentor_view', :layout => false)
    end
  end
  def mentor_delete
   if UserMailer.send_reason(@mentor).deliver
      render :update do |page|
        page.alert("message has been sent to your email")
      end
   end
  end
end