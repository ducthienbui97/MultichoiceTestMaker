class AddNumberOfAnswerToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :number_of_answer, :integer
  end
end
