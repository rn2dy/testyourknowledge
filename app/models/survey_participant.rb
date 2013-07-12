class SurveyParticipant < ActiveRecord::Base
  belongs_to :published_survey
  
  attr_accessible :email, :firstname, :lastname, :published_survey_id, :selects
  validates_presence_of :email, :firstname, :lastname, :published_survey_id
  attr_accessor :selects
  
  before_update :save_user_choices
   
  def save_user_choices
    # group selected answers by bulletin
    choices = Hash.new {|h, k| h[k] = []}
    self.selects.each_pair do |k, v|
      qid = k.split('-')[1]
      choices[qid] << v
    end
    choices.each{ |k, ary| choices[k] = ary.join(',') }
    
    # save user choices
    sp = Nest.new('survey_participants', $redis)
    sp[self.id][:choices].hmset(choices.flatten)
    
    Resque.enqueue(ScoreReportJob, self.id)
  end
  
  def user_choices
    sp = Nest.new('survey_participants', $redis)
    return sp[self.id][:choices].hgetall
  end
  
  def fullname
    "#{firstname} #{lastname}"
  end
end
