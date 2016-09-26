class Question < ActiveRecord::Base
  belongs_to :test
  has_many :answers, dependent: :destroy
  has_many :answers_of_questions, dependent: :destroy
  validates :question_text, presence: true
end
