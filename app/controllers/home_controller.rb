class HomeController < ApplicationController
  def index
  end
  
  def builder
    @survey = Survey.find(params[:survey])
    redirect_to '/404' unless @survey    
  end
end
