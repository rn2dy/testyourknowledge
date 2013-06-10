require 'spec_helper'

describe "questions/show" do
  before(:each) do
    @question = assign(:question, stub_model(Question,
      :title => "Title",
      :score => "Score",
      :order => "Order",
      :survey_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Score/)
    rendered.should match(/Order/)
    rendered.should match(/1/)
  end
end
