class User < ActiveRecord::Base
  has_secure_password
  has_many :questions, dependent: :destroy
  has_many :answers
  validates :email, uniqueness: true
end
