class PublishedSurvey < ActiveRecord::Base
  attr_accessible :email, :survey_id  
  has_many :survey_participants
  
  def survey
    Survey.find(self.survey_id)
  end
end
