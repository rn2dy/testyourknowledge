class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :name
      t.string :description
      t.string :question_ids, default: ''

      t.timestamps
    end
  end
end
