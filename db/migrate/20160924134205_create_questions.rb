class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :question_text, null: false
      t.references :test, index: true, foreign_key: true
      t.integer :point, default: 1
      t.timestamps null: false
    end
  end
end
