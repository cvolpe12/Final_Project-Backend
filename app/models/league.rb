class League < ApplicationRecord
  has_many :teams
  has_many :users, through: :teams

  validates :name, uniqueness: true

  # validates :date_of_games, format: { with: /([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/,
  #   message: "Please match date format" }

end
