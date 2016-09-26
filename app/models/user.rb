class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,  #:omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable #,:omniauth_providers => [:facebook,:google_oauth2]
  has_many :tests, dependent: :destroy
  has_many :submissions, dependent: :destroy
  validates :name, :presence => true
end
