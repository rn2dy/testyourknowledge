require 'spec_helper'

describe "surveys/edit" do
  before(:each) do
    @survey = assign(:survey, stub_model(Survey,
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit survey form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", survey_path(@survey), "post" do
      assert_select "input#survey_name[name=?]", "survey[name]"
      assert_select "input#survey_description[name=?]", "survey[description]"
    end
  end
end
