#require 'juggernaut'
class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :get_layout
  helper_method :current_user
  helper :all
  before_filter :is_loggedin?
  
  def is_loggedin?
    unless current_user
      flash[:error] = "Please login"
      redirect_to "/"
    end
  end
  def after_login(user)
    channels = user.friends.collect{|u| "user-#{u.id}"}

    render :juggernaut => {:type => :send_to_channels, :channels => channels} do |page|
      page.call("Users.find(#{user.id}).update(#{user.json_data.to_json}).updateStatus")
    end
  end

  def after_logout(user)
    channels = user.friends.collect{|u| "user-#{u.id}"}
    iphone_channels = user.friends.collect{|u| "iphone-user-#{u.id}"}

    Juggernaut.send_to_channels_without_sign(user.json_data.to_json, iphone_channels)
    render :juggernaut => {:type => :send_to_channels, :channels => channels} do |page|
      page.call("Users.find(#{user.id}).update(#{user.json_data.to_json}).updateStatus")
    end
  end

  def update_last_activity
    current_user.update_attribute(:last_time_activity, Time.now) if current_user
  end

  private
  #current user student/mentor
  def current_user
    User.find(session[:user_id])
  rescue ActiveRecord::RecordNotFound
  end


  def get_layout
    if current_user
      return current_user.user_type
    else
      return "application"
    end
  end
  
  protected

  #login
  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_path, :notice => "please login"
    end
  end
end
