class RemoveNumberOfAnswerFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :number_of_answer, :integer
  end
end
