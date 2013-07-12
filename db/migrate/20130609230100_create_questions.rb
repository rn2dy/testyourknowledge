class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title, default: '', :null => false
      t.integer :score, default: 0, :null => false

      t.timestamps
    end
  end
end
