class Answer < ActiveRecord::Base

  belongs_to :question
  has_many :answers_of_questions, dependent: :destroy
  validates :description, presence: true
end
