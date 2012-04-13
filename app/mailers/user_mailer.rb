class UserMailer < ActionMailer::Base
  default :from => "from@example.com"

  def signup_notification(user)
    @activation_url = BASE_URL+activate_user_path(user.activation_code)
    @user = user
    mail(:to => user.email, :subject => "Account activation instructions")
  end

  def activation_notification(user)
    @activation_url = BASE_URL
    @user = user
    mail(:to => user.email, :subject => "Account activated succcessfully")
  end

  def password_reset(user)
    @password_reset_url = BASE_URL+reset_password_user_path(user.reset_password_code)
    @user = user
    mail :to => user.email, :subject => "Password Reset instructions"
  end
  
  def send_invitation(invite)
    @invite = invite
    mail(:to => invite.emails , :subject => "Invitation for signup our site")
  end

  def send_invitation_to_friends(import)
    @imported_contact = import
    mail(:to => import.email , :subject => "Invitation for signup our site")
  end

  def new_course_details(course,user)
    @course = course
    @user = user
    mail(:to => user.email , :subject => "New Course Details")
  end

  def send_feedback(suggestion)
    @suggestion = suggestion
    mail(:to => "vivek@dine-media.com", :subject => "#{@suggestion.suggestion_type} #{@suggestion.subject} ")
  end
  def send_reason(mentor)
    @reason_url=BASE_URL
    @mentor = mentor
    mail(:to => mentor.user.email, :subject => "Account activation instructions")
  end
end
