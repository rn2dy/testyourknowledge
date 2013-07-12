class CreatePublishedSurveys < ActiveRecord::Migration
  def change
    create_table :published_surveys do |t|
      t.integer :survey_id, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end
