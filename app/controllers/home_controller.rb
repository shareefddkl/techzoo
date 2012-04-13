class HomeController < ApplicationController
  skip_before_filter :is_loggedin?
  
  def index
    unless current_user
      render :action => "general_index", :layout => "application"
    end
  end
end