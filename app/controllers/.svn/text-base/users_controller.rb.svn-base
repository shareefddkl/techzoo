class UsersController < ApplicationController
  skip_before_filter :is_loggedin?, :only => [:new,  :create, :others, :activate, :forgot_password, :send_reset_password_instructions, :reset_password]

  layout :get_layout, :except => [:others, :create, :update_password, :activate, :forgot_password, :send_reset_password_instructions, :reset_password]

  #GET user
  def new
    @user = User.new
    render :action => "new", :layout => false
  end

  #POST user/id
  def create
    @user = User.new(params[:user])
    if @user.save and UserMailer.signup_notification(@user).deliver
      render :update do |page|
        page.alert("Account has been created and sent activation link to your email") 
      end
    else
      render :update do |page|
        page.replace_html "registor_error", params[:terms_of_service] != 'yes' ? 'Must be agree with terms' : 'Plese enter another email'
      end
    end
  end

  #activate current user/id
  def activate
    @user = User.where("activation_code = '#{params[:id]}'").first
    if @user and @user.activate
      session[:user_id] = @user.id
      flash[:notice] = "Account has been activated. Please create your profile"
      if @user.user_type == "student"
        redirect_to new_student_path
      else
        redirect_to new_mentor_path
      end
    else
      flash[:error] = "Invalid link"
      redirect_to login_path
    end
  end

  #user/type
  def index
    @mentors = Mentor.all
    render :layout => "mentor"
  end

  #get new password
  def forgot_password
   
  end

  #new user password
  def send_reset_password_instructions
    @user = User.where("email = '#{params[:email].strip}'").first
    if @user and @user.generate_password_reset_code 
      render :update do |page|
        page.alert("Password reset instrucions has been sent to '#{params[:email]}'")
      end
    elsif
      render :update do |page|
        params[:email].present? ? page.alert("Please enter the Email") :  page.alert("Invalid Email")
      end
    end
  end

  #set new password
  def reset_password
    @user = User.where("reset_password_code = '#{params[:id]}'").first
    if @user.nil?
      flash[:error] = "Invalid link"
      redirect_to "/login"
    end
  end

  #update the new password
  def update_password
    @user = User.where("reset_password_code = '#{params[:id]}'").first
    if @user and @user.update_attributes(:password => params[:password], :password_confirmation => params[:password_confirmation])
      flash[:notice] = "Password has been changed successfully. Please login"
      redirect_to login_path
    else
      render :action => "reset_password"
    end
  end

  def setting

  end

  def email_setting
    render :action => 'email_setting', :layout => false
  end

  def update_email_setting
    if current_user.update_attributes(params[:user])
      render :update do |page|
        page.replace_html "login_error", "Account has been created and sent activation link to your email"
      end
    end
  end

  def photo
  end
  def update_photo
    if current_user.update_attributes(params[:user])
      flash[:notice]="uploaded the picture"
    else
      flash[:error]="not able to upload the picture"
    end
    redirect_to photo_users_path
  end
  def destroy
    @user = User.find(params[:id])
    if @user.created_at < Date.today && @course.status == 'pending'
      @user.destroy
    end
  end

  def import
    if request.post?
      login = params[:email].to_s
      password = params[:password].to_s
      begin
        case params[:lib]
        when "gmail.com"
          @contacts = Contacts::Gmail.new(login, password)
        when "yahoo.com"
          @contacts = Contacts::Yahoo.new(login, password)
        when "yahoo.co.in"
          @contacts = Contacts::Yahoo.new(login, password)
        when "hotmail.com"
          @contacts =  Contacts::Hotmail.new(login+"@hotmail.com", password)
        when "aol.in"
          @contacts =  Contacts::Aol.new(login+"@aol.in", password)
        else
          @contacts = Contacts::Plaxol.new(login, password)
        end
        @contacts = @contacts.contacts
      rescue
        render :update do |page|
          page.alert("Username and password does not match")
        end
        return
      end
    end
    for contact in @contacts
      email = params[:lib] == 'hotmail.com' ? contact[0].to_s.strip : contact[1].to_s.strip
      name = params[:lib] == 'hotmail.com' ? contact[1].to_s.strip : contact[0].to_s.strip
      if !ImportedContact.exists?(:email => email, :user_id => current_user.id)
        @imported_contact=ImportedContact.new(:user_id => current_user.id, :name => name.to_s, :email => email)
        UserMailer.send_invitation_to_friends(@imported_contact).deliver
        @imported_contact.save
      end
    end
    render :update do |page|
      page.alert("Invitation sent successfully.")
      page.redirect_to home_index_path
    end
    return
  end
  def notification
  end

  def update_notification
    if current_user.update_attributes(params[:user])
      flash[:notice] = "Your's Settings updated succefully"
    else
      flash[:error] = "Your's Settings updation failed"
    end
    redirect_to notification_users_path
  end


end


