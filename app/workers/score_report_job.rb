class ScoreReportJob
  @queue = :score_calculation
  
  def self.perform(survey_participant_id)
    sp = SurveyParticipant.find(survey_participant_id)    
    choices = sp.user_choices
    questions = sp.published_survey.survey.questions
    qcorrect = {}
    qscore = {}    
    
    questions.each do |q|
      strid = "#{q.id}"
      qcorrect[strid] = q.fetch_correctness
      qscore[strid]   = q.score
    end
    
    scores = {}
    choices.each_pair do |k, v|
      if qcorrect[k].length == 1
        scores[k] = (v == qcorrect[k][0] ? qscore[k] : 0)
      else 
        scores[k] = (v.split(',').sort == qcorrect[k].sort ? qscore[k] : 0)
      end
    end
    questions_count = scores.length
    correct_answers_count = scores.reject { |k, v| v == 0 }.length
        
    final_result = { 
      questions_count: questions_count, 
      correct_answers_count: correct_answers_count, 
      detail: scores, 
      total: scores.each_value.inject(0, &:+) 
    }

    SurveyMailer.survey_result_email(survey_participant_id, final_result).deliver
  end
end