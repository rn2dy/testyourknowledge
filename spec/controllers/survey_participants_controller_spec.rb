require 'spec_helper'
describe SurveyParticipantsController do
  describe "POST #create" do
    it "should create participant record and set up session correctly" do
      data = { survey_participant: { firstname: 'Q', lastname: 'H', email: 'test@test.com', published_survey_id: 1 } }
      xhr :post, :create, data
      assigns(:survey_participant).attributes.should include(data[:survey_participant].stringify_keys)
      session.should include({ user_id: assigns(:survey_participant).id }) 
    end
  end
end