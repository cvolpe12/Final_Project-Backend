class TeamSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :league_id
  has_many :players
end
