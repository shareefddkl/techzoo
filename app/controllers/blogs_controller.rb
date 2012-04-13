class BlogsController < ApplicationController
  def index
    
  end

  def search
    @contents = Content.search(params[:query])
  end
end
