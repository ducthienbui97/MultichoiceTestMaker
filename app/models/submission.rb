class Submission < ActiveRecord::Base

  belongs_to :user
  belongs_to :test
  has_many :answers_of_questions, dependent: :destroy
  has_many :question_evaluations, dependent: :destroy
  before_save :default_point
  private
  def default_point
    self.point ||= 0
  end
end
