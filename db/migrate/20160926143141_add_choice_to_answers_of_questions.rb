class AddChoiceToAnswersOfQuestions < ActiveRecord::Migration
  def change
    add_column :answers_of_questions, :choice, :boolean
  end
end
