class CreateQuestionEvaluations < ActiveRecord::Migration
  def change
    create_table :question_evaluations do |t|
      t.references :submission, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.boolean :value
      t.timestamps null: false
    end
  end
end
