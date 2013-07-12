require 'spec_helper'

describe Survey do
  it "raise error if create without a name" do
    expect { create(:survey, name: nil) }.to raise_error
  end
  
  it "does not raise error if created with a name" do
    survey = create(:survey, description: nil)
    survey.name.should == 'Salesforce 101 Knowledge Test'
  end

  it "should have total_score of 0" do
    survey = create(:survey)
    survey.questions.should == []
    survey.total_score.should == 0
  end
end
