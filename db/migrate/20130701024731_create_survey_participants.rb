class CreateSurveyParticipants < ActiveRecord::Migration
  def change
    create_table :survey_participants do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :email, null: false
      t.integer :published_survey_id, null: false

      t.timestamps
    end
  end
end
