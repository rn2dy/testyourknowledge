require 'spec_helper'

describe Question do
  
  before(:each) do
    @q = build(:question)
    
    @config = {
      answers: {
        'A' => 'Answer 1',
        'B' => 'Answer 2'
      },
      correctness: [],
      type: 's'
    }                    
    
    @q.answers = @config[:answers]
    @q.correctness = @config[:correctness]
    @q.type = @config[:type]
  end

  it "should create record with title and score" do
    @q.save!
    @q.title.should == 'What are the differences between Lookup relationship and Master-Detail relationship?'
    @q.score.should == 2
  end
  
  it "should not save answers to question that is not yet saved" do    
    expect {
      @q.save_answers_and_configs
    }.to raise_error('Can not save answers without saving question first!') 
  end
  
  it "should save answers to question that is saved (with an valid id)" do
    @q.save!    
    @q.answers_and_configs.should == @config
  end
  
  it "must have a type" do
    expect {
      @q.type = nil
      @q.save!
    }.to raise_error('Incomplete Answers!')
  end
  
  it "must have at lease two answers" do
    expect {
      @q.answers = { 'B' => 'Answer 2' }
      @q.save!
    }.to raise_error('There must be at least two answers!')
  end     
  
  # it "single-choice must match single correctness" do
  #   expect { 
  #     @q.correctness = ['A', 'B'] 
  #     @q.save!
  #   }.to raise_error('More than one correct answers for single-choice question!')
  # end
  # 
  # it "multi-choice must match multiple correctness" do    
  #   expect { 
  #     @q.type = 'm'
  #     @q.save!
  #   }.to raise_error('Only one correct answers for multi-choice question!')
  # end
  
  after(:each) do
    $redis.flushdb
  end  
end
