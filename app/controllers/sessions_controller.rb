class SessionsController < ApplicationController
  skip_before_filter :is_loggedin?, :only => [:new, :create]
  

  def new
    render :action => "new", :layout => false
  end

  #POST /user/id
  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      user.update_attribute(:last_logged_in_at , Time.now)
      flash[:notice] = "succefully logged in"
      render :update do |page|
        page.redirect_to home_index_path
      end
    else
      render :update do |page|
        page.replace_html "login_error", "Invalid user/password"
      end
    end
  end

  #DELETE /current user
  def destroy
    session[:user_id] = nil
    session.delete(:user_id)
    redirect_to home_index_path, :notice => "Logged out"
  end
end
 
