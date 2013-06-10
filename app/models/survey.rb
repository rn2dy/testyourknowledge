class Survey < ActiveRecord::Base
  attr_accessible :description, :name, :question_ids
  
  def questions
    Question.find(self.question_ids.split(',')) if self.question_ids
    return []
  end
end
