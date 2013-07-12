class SurveyMailer < ActionMailer::Base
  include Resque::Mailer
  
  default from: 'surveybuilder.team@gmail.com'
  
  def published_survey_email(published_survey_id)
    @published_survey = PublishedSurvey.find(published_survey_id)
    mail(to: @published_survey.email, subject: "Survey Builder - Your published survey URL")    
  end
  
  def survey_result_email(survey_participant_id, final_result)
    @survey_participant = SurveyParticipant.find(survey_participant_id)
    @published_survey = @survey_participant.published_survey
    @survey = @published_survey.survey
    @final_result = final_result.symbolize_keys
    mail(to: @survey_participant.email, cc: @published_survey.email, subject: "Survey Builder - Your score of survey '#{@survey.name}'")
  end
end