class AdsController < ApplicationController
  skip_before_filter :is_loggedin? , :only => ['index']
  def index
    @ads = Ad.paginate :page => params[:page], :per_page => 2
  end

  def new
    @ad = Ad.new
  end

  def create
    @ad = Ad.new(params[:ad])
    @ad.user_id = current_user.id
    if @ad.save
      flash[:notice] = "Your's Ad Successfully Created."
      redirect_to edit_ad_path(@ad)
    else
      flash[:error] = "Your's Ad Creation Failed."
      render :action => :new
    end
  end

  def edit
    @ad = Ad.find(params[:id])
  end

  def update
    @ad =  Ad.find(params[:id])
    if @ad.update_attributes(params[:ad])
      flash[:notice]="Your's Ad succefully Updated"
      redirect_to edit_ad_path(@ad)
    else
      flash[:error]="Your's Ad Creation Failed."
      render :action => 'edit'
    end
  end
end
