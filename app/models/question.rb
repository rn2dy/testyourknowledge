class Question < ActiveRecord::Base
  attr_accessible :score, :title, :answers, :correctness, :type

  attr_accessor :answers, :correctness, :type
  
  after_save :save_answers_and_configs
  
  def save_answers_and_configs
    raise 'Can not save answers without saving question first!' if self.new_record?    
    validate_answers_and_configs
    questions = Nest.new('questions', REDIS)
    questions[self.id][:answers].hmset(self.answers.flatten) if self.answers
    
    if self.correctness && self.correctness.length > 0
      questions[self.id][:correctness].sadd(self.correctness) 
    else
      questions[self.id][:correctness].del
    end
      
    questions[self.id][:type].set(self.type) if self.type
  end
  
  def answers_and_configs
    questions = Nest.new('questions', REDIS)
    return { 
      answers: questions[self.id][:answers].hgetall,
      correctness: questions[self.id][:correctness].smembers,
      type: questions[self.id][:type].get 
    }
  end
  
  def fetch_correctness
    questions = Nest.new('questions', REDIS)
    return questions[self.id][:correctness].smembers
  end
  
  def self.save_updates(questions)
    questions.each do |q|
      id = q.delete :id
      find(id).update_attributes(q)
    end
  end
  
  def as_json(options = {})
    base = super({ except: [:created_at, :updated_at] })
    base.merge self.answers_and_configs    
  end
     
  private

    def validate_answers_and_configs      
      raise 'Incomplete Answers!' if !(self.answers && self.type)
      raise 'There must be at least two answers!' if self.answers.length < 2
      # enforce correctness choices at the client side only
      # raise 'More than one correct answers for single-choice question!' if (self.type == 's' && self.correctness.length > 1)
      # raise 'Only one correct answers for multi-choice question!' if (self.type == 'm' && self.correctness.length == 1)      
    end
end