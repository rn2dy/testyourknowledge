class HomeController < ApplicationController
  
  def index
  end
  
  def builder
    @survey = Survey.find(params[:survey_id])
    @questions = @survey.questions
  rescue
    redirect_to '/404' unless @survey    
  end                    
  
end
