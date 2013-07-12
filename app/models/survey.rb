class Survey < ActiveRecord::Base
  attr_accessible :description, :name, :question_ids, :total_score
  validates_presence_of :name  
    
  def questions
    @questions ||= Question.find(self.question_ids.split(',')) if self.question_ids
    @questions || []
  end
  
  def total_score
    result = self.questions.inject(0) do |sum, q|
      sum += q.score
    end
  end

  def as_json(options={})
    base = super({except: [:created_at, :updated_at]})
    base.merge({ total_score: self.total_score })
  end
end
