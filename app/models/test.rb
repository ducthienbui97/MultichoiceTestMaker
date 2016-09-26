class Test < ActiveRecord::Base
  belongs_to :User
  has_many :questions, dependent: :destroy
  has_many :submissions, dependent: :destroy
  validates :description, presence: true
  validates :length, presence: true
  validates :title, presence: true

end
