class AnswersOfQuestion < ActiveRecord::Base

  belongs_to :question
  belongs_to :submission
  belongs_to :answer
end
