class Test < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :submissions, dependent: :destroy
  validates :description, presence: true
  validates :length, presence: true, inclusion: 1..120
  validates :title, presence: true
  validates :token, presence: true
  validates :token, uniqueness: true
  before_validation :generate_token, on: :create
  before_save :default_point

  def to_param
    token
  end

  private
  def default_point
    self.point ||= 0
  end

  def generate_token
    begin
      self.token = SecureRandom.urlsafe_base64
    end while self.class.find_by(token: token)
  end


end
