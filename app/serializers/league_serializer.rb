class LeagueSerializer < ActiveModel::Serializer
  attributes :id, :name, :participants, :limit, :player_source, :date_of_games
  has_many :teams
  has_many :users
  # has_many :players
end
