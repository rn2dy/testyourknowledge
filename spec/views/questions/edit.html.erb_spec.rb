require 'spec_helper'

describe "questions/edit" do
  before(:each) do
    @question = assign(:question, stub_model(Question,
      :title => "MyString",
      :score => "MyString",
      :order => "MyString",
      :survey_id => 1
    ))
  end

  it "renders the edit question form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", question_path(@question), "post" do
      assert_select "input#question_title[name=?]", "question[title]"
      assert_select "input#question_score[name=?]", "question[score]"
      assert_select "input#question_order[name=?]", "question[order]"
      assert_select "input#question_survey_id[name=?]", "question[survey_id]"
    end
  end
end
