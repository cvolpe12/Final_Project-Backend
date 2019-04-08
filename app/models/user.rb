class User < ApplicationRecord
  has_many :teams
  has_many :leagues, through: :teams

  validates :username, uniqueness: true
	has_secure_password
end
