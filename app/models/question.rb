class Question < ActiveRecord::Base

  belongs_to :test
  has_many :answers, dependent: :destroy
  has_many :answers_of_questions, dependent: :destroy
  has_many :question_evaluations, dependent: :destroy
  validates :point, inclusion: 1..10
  validates :question_text, presence: true
  after_save :calculate_point
  private
  def calculate_point
    self.test.update(point: test.questions.sum(:point))
  end
end
