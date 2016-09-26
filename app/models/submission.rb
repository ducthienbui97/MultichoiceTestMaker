class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :test
  has_many :answers_of_questions, dependent: :destroy
end
