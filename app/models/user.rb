class User < ActiveRecord::Base
  has_secure_password
  has_many :questions, dependent: :destroy
  has_many :answers
  validates :email, uniqueness: true, confirmation: true, presence: true
  validates :email_confirmation, presence: true
  validates :name, presence: true
  validates :password, length: { minimum: 6 }, :on => :create
  mount_uploader :avatar, AvatarUploader
end
